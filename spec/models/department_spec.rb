# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  context 'with associations' do
    it { is_expected.to have_many(:employees) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'when create' do
    let(:department) { FactoryBot.create(:department, name: 'Engineering') }

    it 'department name should match' do
      expect(department.name).to eq('Engineering')
    end

    it 'count should be incremented' do
      expect { department }.to change(described_class, :count).by(1)
    end
  end

  context 'when data' do
    let(:department) { described_class.new(name: nil) }

    it 'is invalid' do
      expect(department).not_to be_valid
      expect(department.errors.full_messages).to include("Name can't be blank")
    end
  end
end
