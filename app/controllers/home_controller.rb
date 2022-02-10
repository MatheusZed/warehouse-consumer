class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all
    if @warehouses.nil?
      flash.now['alert'] = 'Nao foi possivel carregar dados dos galpoes'
    end
  end
end
