class Stock < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :bearer
end
