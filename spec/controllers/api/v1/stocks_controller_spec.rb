# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StocksController, type: :controller do
  let(:bearer) { create :bearer }
  let(:stock) { create :stock, bearer: bearer }

  describe 'POST create' do
    let(:stock_params) do
      {
        name: 'new stock',
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
            name: 'new stock',
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
    context 'with valid payload' do
      context 'with existing bearer' do
        it 'updates a stock with existing bearer' do
          #
        end
      end

      context 'with not existent bearer' do
        it 'creates new bearer and updates the stock' do
          #
        end
      end
    end

    context 'with invalid payload' do
      context 'when attributes are invalid' do
        it 'returns serialized error' do
          #
        end
      end

      context 'stock does not exist' do
        it 'returns serialized error' do
          #
        end
      end
    end
  end

  describe 'GET index' do
    it 'returns a list of existing stocks' do
      #
    end
  end

  describe 'DELETE destroy' do
    context 'when stock exists' do
      it 'soft deletes the stock' do
        #
      end
    end

    context 'when stock does not exist' do
      it 'returns serialized error' do
        #
      end
    end
  end
end
