# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StocksController, type: :controller do
  let(:bearer) { create :bearer }
  let(:stock) { create :stock, bearer: bearer }

  describe 'POST create' do
    let(:stock_params) do
      {
        name: 'stock',
        bearer_name: bearer.name
      }
    end

    before do
      post :create, params: stock_params, format: :json
    end

    context 'with valid payload' do
      it 'creates a stock with referenced bearer' do
        expect(parsed_response['data']['id']).to eq(Stock.last.id.to_s)
        expect(parsed_response['data']['attributes']).to eq(
          'name' => stock_params[:name],
          'bearer_name' => stock_params[:bearer_name]
        )
      end
    end

    context 'with invalid payload' do
      context 'when bearer name is blank' do
        let(:stock_params) do
          {
            name: 'stock',
            bearer_name: nil
          }
        end

        it 'returns serialized error' do
          expect(parsed_response['errors'].first['detail']).to eq('Name of bearer can not be blank')
          expect(response.status).to eq(422)
        end
      end

      context 'when stock name is blank' do
        let(:stock_params) do
          {
            name: nil,
            bearer_name: bearer.name
          }
        end

        it 'returns serialized error' do
          expect(parsed_response['errors'].first['detail']).to eq('Name of stock can not be blank')
          expect(response.status).to eq(422)
        end
      end

      context 'when stock name is not unique' do
        let(:stock_params) do
          {
            name: stock.name,
            bearer_name: bearer.name
          }
        end

        it 'returns serialized error' do
          expect(parsed_response['errors'].first['detail']).to eq('Name has already been taken')
          expect(response.status).to eq(422)
        end
      end
    end
  end

  describe 'PUT update' do
    let(:stock_id) { stock.id }
    let(:stock_name) { stock.name }
    let(:bearer_name) { bearer.name }
    let(:stock_params) do
      {
        id: stock_id,
        name: stock_name,
        bearer_name: bearer_name
      }
    end

    before do
      put :update, params: stock_params, format: :json
    end

    context 'with valid payload' do
      let(:stock_name) { 'new stock' }

      context 'with existing bearer' do
        it 'updates a stock with existing bearer' do
          expect(parsed_response['data']['attributes']['name']).to eq(stock_name)
        end
      end

      context 'with not existent bearer' do
        let(:bearer_name) { 'new bearer' }

        it 'creates new bearer and updates the stock' do
          expect(parsed_response['data']['attributes']['name']).to eq(stock_name)
          expect(stock.reload.bearer.name).to eq('new bearer')
        end
      end
    end

    context 'with invalid payload' do
      context 'when attributes are invalid' do
        let(:stock_name) { nil }

        it 'returns serialized error' do
          expect(parsed_response['errors'].first['detail']).to eq('Name of stock can not be blank')
          expect(response.status).to eq(422)
        end
      end

      context 'stock does not exist' do
        let(:stock_id) { 100_500 }

        it 'returns serialized error' do
          expect(parsed_response['errors'].first['detail']).to eq("Couldn't find Stock with 'id'=100500")
          expect(response.status).to eq(404)
        end
      end
    end
  end

  describe 'GET index' do
    let(:existing_stock) { create :stock, name: 'One', bearer: bearer }
    let(:deleted_stock) { create :stock, :deleted, name: 'Two', bearer: bearer }

    before do
      existing_stock
      deleted_stock

      get :index, format: :json
    end

    it 'returns a list of existing stocks' do
      expect(parsed_response['data'].size).to eq(1)
      expect(parsed_response['data'].last['id']).to eq(existing_stock.id.to_s)
    end
  end

  describe 'DELETE destroy' do
    let(:stock_id) { stock.id }
    let(:stock_name) { stock.name }
    let(:bearer_name) { bearer.name }
    let(:stock_params) do
      {
        id: stock_id,
        name: stock_name,
        bearer_name: bearer_name
      }
    end

    before do
      delete :destroy, params: stock_params, format: :json
    end

    context 'when stock exists' do
      it 'soft deletes the stock' do
        expect(parsed_response['data']['attributes']['name']).to eq(stock_name)
        expect(stock.reload.deleted).to eq(true)
      end
    end

    context 'when stock does not exist' do
      let(:stock_id) { 100_500 }

      it 'returns serialized error' do
        expect(parsed_response['errors'].first['detail']).to eq("Couldn't find Stock with 'id'=100500")
        expect(response.status).to eq(404)
      end
    end
  end
end
