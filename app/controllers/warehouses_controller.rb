class WarehousesController < ApplicationController
  def show
    id = params[:id]
    api_domain = Rails.configuration.apis['warehouse_api']
    response = Faraday.get("#{api_domain}/api/v1/warehouses/#{id}")

    case response.status
    when 200
      @warehouse = JSON.parse(response.body)
    when 404
      redirect_to root_path, alert: 'Galpao nao existe'
    else
      redirect_to root_path, alert: 'Nao foi possivel carregar dados do galpao no momento'
    end
  end
end
