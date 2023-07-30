# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupWorker do
  describe '#perform' do
    context 'when enqueued' do
      before { described_class.perform_async }

      it 'is enqueued' do
        expect(described_class).to have_enqueued_sidekiq_job
      end

      it 'is retryable' do
        expect(described_class).to be_retryable true
      end
    end

    context 'when calls perform' do
      it 'groups changes' do
        described_class.new.perform
        expect(Employee.count).to eq(Group.joins(:invitations).where(week: Time.zone.today.cweek).count)
      end
    end
  end
end
