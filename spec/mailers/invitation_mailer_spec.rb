# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationMailer, type: :mailer do
  describe 'when invite' do
    let(:employee) { FactoryBot.create(:employee) }
    let(:invitation) { FactoryBot.create(:invitation, employee:) }
    let(:mail) { described_class.send_invitation(employee, invitation) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Invitation to BlindDate')
    end

    it 'renders the headers' do
      expect(mail.to).to eq([employee.email])
      expect(mail.from).to eq(['from@mail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
