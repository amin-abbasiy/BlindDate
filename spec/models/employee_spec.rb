# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { FactoryBot.create(:employee) }

  context 'with associations' do
    it { is_expected.to have_many(:groups) }
    it { is_expected.to belong_to(:department) }
    it { is_expected.to have_many(:invitations) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to allow_value('test@mail.com').for(:email) }
  end

  context 'when create' do
    let(:employee) { FactoryBot.create(:employee, email: 'test@mail.com') }

    it 'employee email should match' do
      expect(employee.email).to eq('test@mail.com')
    end

    it 'count should be incremented' do
      expect { employee }.to change(described_class, :count).by(1)
    end
  end

  context 'when data' do
    let(:employee) { described_class.new(email: nil, password: nil) }

    it 'is invalid' do
      expect(employee).not_to be_valid
      expect(employee.errors.full_messages).to include('Department must exist',
                                                       "Email can't be blank",
                                                       'Email is invalid',
                                                       "Password can't be blank")
    end
  end
end
