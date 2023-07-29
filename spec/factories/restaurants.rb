# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }
    address { Faker::Address.street_address }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
