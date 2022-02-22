class Warehouse
  attr_accessor :id, :name, :code, :address, :postal_code, :city, :state, :description, :total_area, :useful_area

  def initialize(id:, name:, code:, description:, address:, postal_code:, city:, state:, total_area:, useful_area:)
    @id = id
    @name = name
    @code = code
    @description = description
    @address = address
    @postal_code = postal_code
    @city = city
    @state = state
    @total_area = total_area
    @useful_area = useful_area
  end

  def self.all
    api_domain = Rails.configuration.apis['warehouse_api']
    response = Faraday.get("#{api_domain}/api/v1/warehouses")
    result = []

    if response.status == 200
      warehouses = JSON.parse(response.body)
      warehouses.each do |w|
        result << Warehouse.new(
          id: w['id'], name: w['name'], code: w['code'],
          address: w['address'], postal_code: w['postal_code'],
          city: w['city'], state: w['state'], description: w['description'],
          total_area: w['total_area'], useful_area: w['useful_area']
        )
      end
    else
      return nil
    end

    result
  end

  def self.find(id)
    api_domain = Rails.configuration.apis['warehouse_api']
    response = Faraday.get("#{api_domain}/api/v1/warehouses/#{id}")

    if response.status == 200
      w = JSON.parse(response.body)
      Warehouse.new(
        id: w['id'], name: w['name'], code: w['code'],
        address: w['address'], postal_code: w['postal_code'],
        city: w['city'], state: w['state'], description: w['description'],
        total_area: w['total_area'], useful_area: w['useful_area']
      )
    elsif response.status == 404
      return nil, alert: 'Nao foi possivel carregar dados do galpao no momento'
    else
      return nil, alert: 'Galpao nao existe'
    end
  end
end
