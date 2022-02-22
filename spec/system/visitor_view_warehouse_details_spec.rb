require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    # Arrange
    wh = []
    wh << Warehouse.new(
      id: 1, name: 'Guarulhos', code: 'GRU', address: 'Rua A',
      postal_code: '00000-000', city: 'Osasco', state: 'SP',
      description: 'Casa de praia', total_area: 200, useful_area: 100
    )
    allow(Warehouse).to receive(:all).and_return(wh)
    allow(Warehouse).to receive(:find).with('1').and_return(wh.first)

    # Act
    visit root_path
    click_on 'Guarulhos'

    # Assert
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Rua A'
    expect(page).to have_content '00000-000'
    expect(page).to have_content 'Osasco'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'Casa de praia'
    expect(page).to have_content '200'
    expect(page).to have_content '100'
  end

  # it 'and the API is no longer responding' do
  #   # Arrange
  #   wh = []
  #   wh << Warehouse.new(
  #     id: 1, name: 'Guarulhos', code: 'GRU', address: 'Rua A',
  #     postal_code: '00000-000', city: 'Osasco', state: 'SP',
  #     description: 'Casa de praia', total_area: 200, useful_area: 100
  #   )
  #   allow(Warehouse).to receive(:all).and_return(wh)
  #   allow(Warehouse).to receive(:find).with('').and_return(wh.first)

  #   # Act
  #   visit root_path
  #   click_on 'Guarulhos'

  #   # Assert
  #   expect(current_path).to eq root_path
  #   expect(page).to have_content 'Nao foi possivel carregar dados do galpao no momento'
  # end

  # it "and the warehouse doesn't exist" do
  #   # Arrange
  #   wh = []
  #   wh << Warehouse.new(
  #     id: 1, name: 'Guarulhos', code: 'GRU', address: 'Rua A',
  #     postal_code: '00000-000', city: 'Osasco', state: 'SP',
  #     description: 'Casa de praia', total_area: 200, useful_area: 100
  #   )
  #   allow(Warehouse).to receive(:all).and_return(wh)
  #   allow(Warehouse).to receive(:find).with('9999').and_return(wh.first)

  #   # Act
  #   visit warehouse_path(9999)

  #   # Assert
  #   expect(current_path).to eq root_path
  #   expect(page).to have_content 'Galpao nao existe'
  # end
end
