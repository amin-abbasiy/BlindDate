# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    week { Faker::Number.between(from: 1, to: 52) }
    restaurant

    trait :with_members do
      transient do
        members_count { 3 }
      end

      after(:create) do |group, evaluator|
        create(:invitation, role: 'leader', group:, status: 'accepted')
        create_list(:invitation, evaluator.members_count, group:, status: 'accepted')
      end
    end
  end
end
