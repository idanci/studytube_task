class StockSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :bearer_name do |stock|
    stock.bearer.name
  end
end
