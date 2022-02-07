class HomeController < ApplicationController
  def index
    api_domain = Rails.configuration.apis['warehouse_api']
    response = Faraday.get("#{api_domain}/api/v1/warehouses")
    @warehouses = []
    if response.status == 200
      @warehouses = JSON.parse(response.body)
    else
      flash['alert'] = 'Nao foi possivel carregar dados dos galpoes'
    end
  end
end
