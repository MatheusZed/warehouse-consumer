require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    # Arrange
    warehouses = []
    warehouses << Warehouse.new(
      id: 1, name: 'Guarulhos', code: 'GRU', address: 'Rua A',
      postal_code: '00000-000', city: 'Guarulhos', state: 'Guarulhos',
      description: 'a', total_area: 200, useful_area: 100
    )
    warehouses << Warehouse.new(
      id: 2, name: 'Salvador', code: 'SSA', address: 'Rua B',
      postal_code: '00000-000', city: 'Salvador', state: 'Salvador',
      description: 'a', total_area: 200, useful_area: 100
    )
    allow(Warehouse).to receive(:all).and_return(warehouses)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Salvador'
    expect(page).to have_content 'SSA'
  end

  it "and there's no warehouse" do
    # Arrange
    allow(Warehouse).to receive(:all).and_return([])

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Nenhum galpao disponivel'
  end

  it 'and render an error message ig API is unavailable' do
    # Arrange
    allow(Warehouse).to receive(:all).and_return(nil)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Nao foi possivel carregar dados dos galpoes'
  end
end
