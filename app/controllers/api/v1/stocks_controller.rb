# frozen_string_literal: true

class Api::V1::StocksController < Api::BaseController
  before_action :stock, only: %i[update destroy]

  def create
    render jsonapi: bearer.stocks.create!(name: stock_params[:name])
  end

  def update
    attributes = { name: stock_params[:name] }
    attributes[:bearer] = bearer if stock_params[:bearer_name]

    stock.update!(attributes)

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
    @bearer ||= Bearer.find_or_create_by!(name: stock_params[:bearer_name])
  end

  def stock
    @stock ||= Stock.find_by!(id: params[:id], deleted: false)
  end

  def stock_params
    params.permit(:name, :bearer_name)
  end
end
