# frozen_string_literal: true

module Api
  class Stocks < Grape::API
    resource :stocks do
      desc 'List all stocks with bearer information'
      get do
        stocks = Stock.all.includes(:bearer)
        present stocks, with: Entities::Stock
      end

      desc 'Create a new stock'
      params do
        requires :name, type: String, desc: 'Stock name', allow_blank: false
        requires :bearer, type: String, desc: 'Bearer name', allow_blank: false
      end
      post do
        declared_params = declared(params, include_missing: false)

        bearer = Bearer.find_or_initialize_by(name: params[:bearer])
        stock = Stock.create!(declared_params.merge(bearer:))
        present stock, with: Entities::Stock
      end

      desc 'Update a stock'
      params do
        requires :name, type: String, desc: 'Stock name', allow_blank: false
      end
      patch ':id' do
        declared_params = declared(params, include_missing: false)

        stock = Stock.find(params[:id])
        stock.update!(declared_params)
        present stock, with: Entities::Stock
      end

      desc 'Delete a stock'
      delete ':id' do
        stock = Stock.find(params[:id])
        stock.destroy!
        body false
      end
    end
  end
end
