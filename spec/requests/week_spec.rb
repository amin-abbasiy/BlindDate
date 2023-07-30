# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups#Week', type: :request do
  describe 'GET /week/:week' do
    context 'when calls GET week groups' do
      let(:groups) { FactoryBot.create_list(:group, 2, week: 1) }

      before { groups }

      it 'status should be' do
        get '/api/v1/groups/week/1'
        expect(response).to have_http_status(:ok)
      end

      it 'result should include' do
        get '/api/v1/groups/week/1'

        expect(JSON.parse(body)).to include('data')
      end

      it 'result size should match' do
        get '/api/v1/groups/week/1'

        expect(JSON.parse(body)['data'].size).to eq(2)
      end
    end

    context 'with expected output' do
      let(:restaurant) { FactoryBot.create(:restaurant) }
      let(:group) { FactoryBot.create(:group, :with_members, restaurant:, week: 1) }
      let(:group2) { FactoryBot.create(:group, :with_members, restaurant:, week: 2) }

      let(:valid_response) do
        {
          data: [
            {
              id: group.id.to_s,
              type: 'group',
              attributes: {
                week: 1
              },
              relationships: {
                members: {
                  data: [
                    {
                      email: group.members.first.email,
                      position: 0,
                      department: group.members.first.department.name
                    },
                    {
                      email: group.members.second.email,
                      position: 0,
                      department: group.members.second.department.name
                    },
                    {
                      email: group.members.third.email,
                      position: 0,
                      department: group.members.third.department.name
                    },
                    {
                      email: group.members.fourth.email,
                      position: 0,
                      department: group.members.fourth.department.name
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
        group2
      end

      it 'is like' do
        get '/api/v1/groups/week/1'

        expect(body).to include_json(valid_response)
      end
    end

    context 'when calls GET with Non existing Id' do
      it 'status should be' do
        get '/api/v1/groups/week/1000'
        expect(response).to have_http_status(:ok)
      end

      it 'result should include' do
        get '/api/v1/groups/week/1000'

        expect(JSON.parse(body)).to include('data')
      end

      it 'result size should match' do
        get '/api/v1/groups/week/1000'

        expect(JSON.parse(body)['data'].size).to eq(0)
      end
    end
  end
end
