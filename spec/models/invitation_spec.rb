# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject { FactoryBot.create(:invitation) }

  context 'with associations' do
    it { is_expected.to belong_to(:employee) }
    it { is_expected.to belong_to(:group) }
  end

  context 'with enumerations' do
    it { is_expected.to define_enum_for(:status).with_values(%i[pending accepted rejected]) }
    it { is_expected.to define_enum_for(:role).with_values(%i[member leader]) }
  end

  context 'when create' do
    let(:invitation) { FactoryBot.create(:invitation) }

    it 'invitation should have employee and group' do
      expect(invitation.group).to be_present
      expect(invitation.employee).to be_present
    end

    it 'count should be incremented' do
      expect { invitation }.to change(described_class, :count).by(1)
    end
  end

  context 'when data' do
    let(:invitation) { described_class.new(group: nil, employee: nil) }

    it 'is invalid' do
      expect(invitation).not_to be_valid
      expect(invitation.errors.full_messages).to include('Employee must exist',
                                                         'Group must exist')
    end
  end
end
