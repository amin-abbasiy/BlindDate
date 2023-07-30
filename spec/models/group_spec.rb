# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  subject { FactoryBot.create(:group) }

  context 'with associations' do
    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:accepted_invitations) }
    it { is_expected.to have_one(:leader) }
    it { is_expected.to have_many(:members) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:week) }
  end

  context 'with scopes' do
    let(:group) { FactoryBot.create(:group, week: 1) }
    let(:group2) { FactoryBot.create(:group, week: 2) }

    it 'weekly_groups should match' do
      expect(described_class.weekly_groups(1)).to include(group)
    end

    it 'weekly_groups should not match' do
      expect(described_class.weekly_groups(1)).not_to include(group2)
    end
  end

  context 'when create' do
    let(:group) { FactoryBot.create(:group, :with_members, week: 1) }

    it 'group email should match' do
      expect(group.week).to eq(1)
    end

    it 'count should be incremented' do
      expect { group }.to change(described_class, :count).by(1)
    end

    it '4 members should be added' do
      expect { group }.to change(Invitation, :count).by(4)
    end
  end

  context 'when data' do
    let(:group) { described_class.new(week: nil) }

    it 'is invalid' do
      expect(group).not_to be_valid
      expect(group.errors.full_messages).to include("Week can't be blank")
    end
  end
end
