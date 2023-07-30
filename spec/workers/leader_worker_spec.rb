# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeaderWorker do
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
  end
end
