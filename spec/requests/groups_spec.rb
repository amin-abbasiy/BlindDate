# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  describe 'GET /groups' do
    context 'when calls GET groups' do
      let(:group) { FactoryBot.create_list(:group, 2) }

      before { group }

      it 'status should be' do
        get '/api/v1/groups'
        expect(response).to have_http_status(:ok)
      end

      it 'result should include' do
        get '/api/v1/groups'

        expect(JSON.parse(body)).to include('data')
      end

      it 'result size should match' do
        get '/api/v1/groups'
        expect(JSON.parse(body)['data'].size).to eq(2)
      end
    end

    context 'with expected output' do
      let(:restaurant) { FactoryBot.create(:restaurant) }
      let(:group) { FactoryBot.create(:group, :with_members, restaurant:, week: Time.zone.today.cweek) }

      let(:valid_response) do
        {
          data: [
            {
              id: group.id.to_s,
              type: 'group',
              attributes: {
                week: Time.zone.today.cweek
              },
              relationships: {
                members: {
                  data: [
                    {
                      email: group.members.first.email,
                      position: 0,
                      department: group.members.first.department.name
                    }
                  ]
                },
                restaurant: {
                  data: {
                    name: restaurant.name,
                    address: restaurant.address,
                    'phone-number': restaurant.phone_number
                  }
                },
                leader: {
                  data: {
                    email: group.leader.employee.email,
                    position: 0,
                    department: group.leader.employee.department.name
                  }
                }
              }
            }
          ]
        }
      end

      before do
        restaurant
        group
      end

      it 'is like' do
        get '/api/v1/groups'

        expect(body).to include_json(valid_response)
      end
    end
  end
end
