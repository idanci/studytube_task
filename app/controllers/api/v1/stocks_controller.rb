# frozen_string_literal: true

class Api::V1::StocksController < Api::BaseController
  before_action :bearer, only: %i[create update]

  def create
    stock = @bearer.stocks.create!(name: stock_params[:name])

    render jsonapi: stock
  end

  def update
    stock.update!(name: stock_params[:name], bearer: bearer)

    render jsonapi: stock
  end

  def index
    render jsonapi: Stock.where(deleted: false)
  end

  def destroy
    stock.soft_delete!

    render jsonapi: stock
  end

  private

  def bearer
    @bearer = Bearer.find_or_create_by!(name: stock_params[:bearer_name])
  end

  def stock
    @stock ||= Stock.find(params[:id])
  end

  def stock_params
    params.permit(:name, :bearer_name)
  end
end
