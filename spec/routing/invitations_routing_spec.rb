# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::InvitationsController, type: :routing do
  it 'routes to #accept' do
    expect(patch: 'api/v1/invitations/1').to route_to('api/v1/invitations#update', id: '1')
  end
end
