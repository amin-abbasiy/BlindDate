# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    position { Faker::Job.position }
    department
  end
end
