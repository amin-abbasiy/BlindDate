# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    name { Faker::Company.department + rand(1..1000).to_s }
  end
end
