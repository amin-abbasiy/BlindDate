# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/groups').to route_to('api/v1/groups#index')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/groups').to route_to('api/v1/groups#create')
    end

    it 'routes to #week' do
      expect(get: 'api/v1/groups/week/12').to route_to('api/v1/groups#week', week: '12')
    end
  end
end
