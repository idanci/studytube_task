# frozen_string_literal: true

FactoryBot.define do
  factory :bearer do
    name { 'bearer' }
  end
  factory :stock do
    name { 'stock' }
    bearer

    trait :deleted do
      deleted { true }
    end
  end
end
