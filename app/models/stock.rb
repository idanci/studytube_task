# frozen_string_literal: true

class Stock < ApplicationRecord
  validates :name, presence: { message: 'of stock can not be blank' }
  validates :name, uniqueness: true

  belongs_to :bearer

  def soft_delete!
    update!(deleted: true)
  end
end
