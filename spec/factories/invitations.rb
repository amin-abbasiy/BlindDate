# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    status { %w[pending accepted rejected].sample }
    role { 'member' }
    employee
    group
  end
end
