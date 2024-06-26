# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    sequence(:name) { |n| "name_#{n}" }
  end
end
