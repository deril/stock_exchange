# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/stocks', type: :request do
  let(:bearer) { create(:bearer, name: 'NASDAQ') }
  let(:valid_attributes) do
    {
      name: 'Apple',
      bearer: 'NASDAQ'
    }
  end

  let(:invalid_attributes) do
    {
      name: 'Apple'
    }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    subject(:get_index) { get '/stocks', headers: valid_headers }

    let(:expected_response_body) do
      [
        {
          'id' => stock.id,
          'name' => 'Apple',
          'bearer' => {
            'id' => bearer.id,
            'name' => 'NASDAQ'
          }
        }
      ]
    end
    let!(:stock) { create(:stock, name: 'Apple', bearer:) }

    it 'renders a successful response', :aggregate_failures do
      get_index

      expect(response).to be_successful
      expect(json_response).to eq(expected_response_body)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      subject(:post_create) { post '/stocks', params: valid_attributes, headers: valid_headers }

      it 'creates a new Stock', :aggregate_failures do
        expect { post_create }.to change(Stock, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'reuses the bearer if it exists', :aggregate_failures do
        create(:bearer, name: valid_attributes[:bearer])

        expect { post_create }.to change(Bearer, :count).by(0)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          name: stock_name,
          bearer: bearer_name
        }
      end
      let(:stock_name) { 'Apple' }
      let(:bearer_name) { 'NASDAQ' }

      context 'when parameters are missing' do
        subject(:post_create) { post '/stocks', params: invalid_attributes, headers: valid_headers }

        let(:bearer_name) { nil }
        let(:stock_name) { nil }

        it 'renders a validation error', :aggregate_failures do
          post_create

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq('error' => ['name is empty', 'bearer is empty'])
        end
      end

      context 'when stock name has already been taken' do
        subject(:post_create) { post '/stocks', params: invalid_attributes, headers: valid_headers }

        let(:stock_name) { 'Apple' }

        before { create(:stock, name: stock_name) }

        it 'renders a validation error', :aggregate_failures do
          post_create

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq('error' => ['Validation failed: Name has already been taken'])
        end
      end
    end
  end

  describe 'PATCH /update' do
    let!(:stock) { create(:stock, name: 'Apple', bearer:) }

    context 'with valid parameters' do
      subject(:patch_update) { patch "/stocks/#{stock.id}", params: new_attributes, headers: valid_headers }

      let(:new_attributes) do
        {
          name: 'Google'
        }
      end
      let(:expected_response_body) do
        {
          'id' => stock.id,
          'name' => 'Google',
          'bearer' => {
            'id' => bearer.id,
            'name' => 'NASDAQ'
          }
        }
      end

      it 'updates the requested stock', :aggregate_failures do
        patch_update

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq(expected_response_body)
      end

      context 'when bearer is present' do
        let(:invalid_attributes) do
          {
            name: 'Google',
            bearer: 'AMEX'
          }
        end
        let(:expected_response_body) do
          {
            'id' => stock.id,
            'name' => 'Google',
            'bearer' => {
              'id' => bearer.id,
              'name' => 'NASDAQ'
            }
          }
        end

        it 'renders does not create a new bearer', :aggregate_failures do
          expect { patch_update }.to change(Bearer, :count).by(0)

          expect(response).to have_http_status(:ok)
          expect(json_response).to eq(expected_response_body)
        end
      end
    end

    context 'with invalid parameters' do
      subject(:patch_update) { patch "/stocks/#{stock.id}", params: invalid_attributes, headers: valid_headers }

      let(:invalid_attributes) { {} }

      it 'renders a validation error', :aggregate_failures do
        patch_update

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to eq('error' => ['name is missing', 'name is empty'])
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:delete_destroy) { delete "/stocks/#{stock.id}", headers: valid_headers }

    let!(:stock) { create(:stock, name: 'Apple', bearer:) }

    it 'destroys the requested stock' do
      expect { delete_destroy }.to change(Stock, :count).by(-1)
    end

    context 'when wrong id is passed' do
      subject(:delete_destroy) { delete '/stocks/wrong-id', headers: valid_headers }

      it 'renders a validation error', :aggregate_failures do
        delete_destroy

        expect(response).to have_http_status(:not_found)
        expect(json_response).to eq('error' => "Couldn't find Stock with 'id'=wrong-id")
      end
    end
  end
end
