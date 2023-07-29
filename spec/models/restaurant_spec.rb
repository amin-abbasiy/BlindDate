# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  subject { FactoryBot.create(:restaurant) }

  context 'with associations' do
    it { is_expected.to have_many(:groups) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  context 'when create' do
    let(:restaurant) { FactoryBot.create(:restaurant, name: 'Barbecue') }

    it 'restaurant email should match' do
      expect(restaurant.name).to eq('Barbecue')
    end

    it 'count should be incremented' do
      expect { restaurant }.to change(described_class, :count).by(1)
    end
  end

  context 'when data' do
    let(:restaurant) { described_class.new(name: nil, address: nil) }

    it 'is invalid' do
      expect(restaurant).not_to be_valid
      expect(restaurant.errors.full_messages).to include("Name can't be blank",
                                                         "Address can't be blank")
    end
  end
end
