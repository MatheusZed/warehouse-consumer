class Warehouse
  attr_accessor :id, :name, :code, :address, :postal_code, :city, :state

  def initialize(id:, name:, code:, address:, postal_code:, city:, state:)
    @id = id
    @name = name
    @code = code
    @address = address
    @postal_code = postal_code
    @city = city
    @state = state
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
          city: w['city'], state: w['state']
        )
      end
    else
      return nil
    end

    result
  end
end
