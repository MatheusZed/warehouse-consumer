class WarehousesController < ApplicationController
  def show
    id = params[:id]
    response = Faraday.get("http://localhost:3000/api/v1/warehouses/#{id}")

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
