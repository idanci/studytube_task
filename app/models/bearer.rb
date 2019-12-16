# frozen_string_literal: true

class Bearer < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :stocks
end
