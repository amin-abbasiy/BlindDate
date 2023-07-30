# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Invitations', type: :request do
  describe 'PATCH Invitations' do
    context 'when calls patch accept' do
      let(:group) { FactoryBot.create(:group, week: Time.zone.today.cweek) }
      let(:invitation) { FactoryBot.create(:invitation, group:) }

      let(:valid_params) { { status: 'accepted' } }

      it 'status should be' do
        patch "/api/v1/invitations/#{invitation.id}", params: valid_params

        expect(response).to have_http_status(:ok)
      end

      it 'when size should match' do
        patch "/api/v1/invitations/#{invitation.id}", params: valid_params

        expect(JSON.parse(body)['message']).to eq('Your Response has been recorded')
      end
    end

    context 'when calls patch reject' do
      let(:group) { FactoryBot.create(:group, week: Time.zone.today.cweek) }
      let(:invitation) { FactoryBot.create(:invitation, group:) }

      let(:valid_params) { { status: 'rejected' } }

      it 'status should be' do
        patch "/api/v1/invitations/#{invitation.id}", params: valid_params
        expect(response).to have_http_status(:ok)
      end

      it 'when size should match' do
        patch "/api/v1/invitations/#{invitation.id}", params: valid_params

        expect(JSON.parse(body)['message']).to eq('Your Response has been recorded')
      end
    end
  end

  describe 'PATCH Invalid Invitations' do
    context 'when calls patch invalid' do
      let(:group) { FactoryBot.create(:group, week: Time.zone.today.cweek) }
      let(:invitation) { FactoryBot.create(:invitation, group:) }

      let(:invalid_params) { { status: 'invalid' } }

      let(:error_response) do
        JSON.parse(File.read(Rails.root.join('spec/fixtures/invitation_response_argument_error.json')))
      end

      it 'status should be' do
        patch "/api/v1/invitations/#{invitation.id}", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'when size should match' do
        patch "/api/v1/invitations/#{invitation.id}", params: invalid_params

        expect(JSON.parse(body)).to eq(error_response)
      end
    end

    context 'when time is invalid' do
      let(:group) { FactoryBot.create(:group, week: 1) }
      let(:invitation) { FactoryBot.create(:invitation, group:) }

      let(:invalid_params) { { status: 'accepted' } }

      let(:error_response) do
        JSON.parse(File.read(Rails.root.join('spec/fixtures/create_group_404_response.json')))
      end

      it 'status should be' do
        patch "/api/v1/invitations/#{invitation.id}", params: invalid_params
        expect(response).to have_http_status(:not_found)
      end

      it 'when size should match' do
        patch "/api/v1/invitations/#{invitation.id}", params: invalid_params

        expect(JSON.parse(body)).to eq(error_response)
      end
    end
  end
end
