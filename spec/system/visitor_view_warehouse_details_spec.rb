require 'rails_helper'

describe 'Visitor view warehouses' do
  it 'on home page' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec/support/api_resources/warehouses.json'))
    r = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

    warehouse = File.read(Rails.root.join('spec/support/api_resources/warehouse.json'))
    sr = Faraday::Response.new(status: 200, response_body: warehouse)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(sr)

    # Act
    visit root_path
    click_on 'Guarulhos'

    # Assert
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Cidade pequena grande'
    expect(page).to have_content 'Rua sao joao dos campos'
    expect(page).to have_content '06162-250'
  end

  it 'and the API is no longer responding' do
    # Arrange
    warehouses = File.read(Rails.root.join('spec/support/api_resources/warehouses.json'))
    r = Faraday::Response.new(status: 200, response_body: warehouses)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

    sr = Faraday::Response.new(status: 500, response_body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(sr)

    # Act
    visit root_path
    click_on 'Guarulhos'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Nao foi possivel carregar dados do galpao no momento'

  end
end
