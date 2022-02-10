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
end
