require 'rails_helper'

describe Warehouse do
  context '.all' do
    it 'should return all warehouses' do
      # Arrange
      warehouses = File.read(Rails.root.join('spec/support/api_resources/warehouses.json'))
      r = Faraday::Response.new(status: 200, response_body: warehouses)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

      # Act
      result = Warehouse.all

      # Assert
      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Guarulhos'
      expect(result.last.name).to eq 'Salvador'
    end

    it 'should return empty if theres no warehouse' do
      # Arrange
      r = Faraday::Response.new(status: 200, response_body: '[]')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq []
    end

    it 'should return nil if API is unavailable' do
      # Arrange
      r = Faraday::Response.new(status: 500, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

      # Act
      result = Warehouse.all

      # Assert
      expect(result).to eq nil
    end
  end

  context '.find(id)' do
    it 'should show a warehouse' do
      # Arrange
      warehouses = File.read(Rails.root.join('spec/support/api_resources/warehouses.json'))
      r = Faraday::Response.new(status: 200, response_body: warehouses)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

      warehouse = File.read(Rails.root.join('spec/support/api_resources/warehouse.json'))
      sr = Faraday::Response.new(status: 200, response_body: warehouse)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(sr)

      # Act
      response_body = JSON.parse(sr.body)['id']
      result = Warehouse.find(response_body)

      # Assert
      expect(result.id).to be_a_kind_of Integer
      expect(result.name).to eq 'Guarulhos'
      expect(result.code).to eq 'GRU'
      expect(result.state).to eq 'SP'
      expect(result.city).to eq 'Guarulhos'
      expect(result.postal_code).to eq '06162-250'
      expect(result.address).to eq 'Rua sao joao dos campos'
      expect(result.description).to eq 'Cidade pequena grande'
      expect(result.total_area).to eq 2000
      expect(result.useful_area).to eq 1900
    end

    it 'and the API is no longer responding' do
      # Arrange
      warehouses = File.read(Rails.root.join('spec/support/api_resources/warehouses.json'))
      r = Faraday::Response.new(status: 200, response_body: warehouses)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

      sr = Faraday::Response.new(status: 500, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(sr)

      # Act
      result = Warehouse.find(1)

      # Assert
      expect(result[0]).to eq nil
      expect(result[1][:alert]).to eq 'Galpao nao existe'
    end

    it "and the warehouse doesn't exist" do
      # Arrange
      warehouses = File.read(Rails.root.join('spec/support/api_resources/warehouses.json'))
      r = Faraday::Response.new(status: 200, response_body: warehouses)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(r)

      sr = Faraday::Response.new(status: 404, response_body: '{}')
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/9999').and_return(sr)

      # Act
      result = Warehouse.find(9999)

      # Assert
      expect(result[0]).to eq nil
      expect(result[1][:alert]).to eq 'Nao foi possivel carregar dados do galpao no momento'
    end
  end
end
