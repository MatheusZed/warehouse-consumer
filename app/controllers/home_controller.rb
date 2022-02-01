class HomeController < ApplicationController
  def index
    response = Faraday.get('http://localhost:3000/api/v1/warehouses')
    @warehouses = []
    if response.status == 200
      @warehouses = JSON.parse(response.body)
    else
      flash['alert'] = 'Nao foi possivel carregar dados dos galpoes'
    end
  end
end
