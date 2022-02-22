class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)

    redirect_to root_path if @warehouse.nil?
  end
end
