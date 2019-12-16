require 'rails_helper'

RSpec.describe Api::V1::StocksController, type: :controller do
  describe 'POST create' do
    context 'with valid payload' do
      it 'creates a stock with referenced bearer' do
        #
      end
    end
    context 'with invalid payload' do
      it 'returns serialized error' do
        #
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
