# frozen_string_literal: true

class Bearer < ApplicationRecord
  validates :name, presence: { message: 'of bearer can not be blank' }
  validates :name, uniqueness: true

  has_many :stocks
end
