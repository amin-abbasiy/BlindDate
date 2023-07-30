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

  describe 'POST /groups' do
    context 'with valid data' do
      let(:members) { FactoryBot.create_list(:employee, 4) }
      let(:valid_params) do
        {
          week: Time.zone.today.cweek,
          member_ids: [members.pluck(:id)]
        }
      end

      let(:valid_response) do
        {
          data: {
            id: Group.last.id.to_s,
            type: 'group',
            attributes: {
              week: Time.zone.today.cweek
            },
            relationships: {
              members: {
                data: []
              },
              'invited-members': {
                data: [
                  {
                    email: members.first.email,
                    position: 0,
                    department: members.first.department.name
                  },
                  {
                    email: members.second.email,
                    position: 0,
                    department: members.second.department.name
                  },
                  {
                    email: members.third.email,
                    position: 0,
                    department: members.third.department.name
                  },
                  {
                    email: members.fourth.email,
                    position: 0,
                    department: members.fourth.department.name
                  }
                ]
              },
              restaurant: {
                data: {}
              },
              leader: {
                data: {}
              }
            }
          }
        }
      end

      it 'has 4 invitations' do
        expect do
          post '/api/v1/groups', params: valid_params
        end.to change(Invitation, :count).by(4)
      end

      it 'has 1 group' do
        expect do
          post '/api/v1/groups', params: valid_params
        end.to change(Group, :count).by(1)
      end

      it 'is created' do
        post '/api/v1/groups', params: valid_params

        expect(response).to have_http_status(:created)
      end

      it 'has valid response' do
        post '/api/v1/groups', params: valid_params

        expect(body).to include_json(valid_response)
      end
    end

    context 'with invalid data' do
      let(:random_ids) { (1..4).map { rand(10**10) } }
      let(:invalid_group_params) do
        {
          week: nil,
          member_ids: random_ids
        }
      end

      let(:invalid_member_params) do
        {
          week: 12,
          member_ids: random_ids
        }
      end

      let(:entity_error_response) do
        JSON.parse(File.read(Rails.root.join('spec/fixtures/create_group_422_response.json')))
      end

      let(:not_found_error_response) do
        JSON.parse(File.read(Rails.root.join('spec/fixtures/create_group_404_response.json')))
      end

      it '422 error' do
        post '/api/v1/groups', params: invalid_group_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns 404 error' do
        post '/api/v1/groups', params: invalid_member_params

        expect(response).to have_http_status(:not_found)
      end

      it 'returns 422 error message' do
        post '/api/v1/groups', params: invalid_group_params

        expect(body).to include_json(entity_error_response)
      end

      it 'returns 404 error message' do
        post '/api/v1/groups', params: invalid_member_params

        expect(body).to include_json(not_found_error_response)
      end
    end

    context 'with invalid members' do
      let(:invalid_member_count) do
        {
          week: 12,
          member_ids: []
        }
      end

      let(:error_response) do
        JSON.parse(File.read(Rails.root.join('spec/fixtures/create_group_member_error_response.json')))
      end

      it 'returns 422 error' do
        post '/api/v1/groups', params: invalid_member_count

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns inefficient member error message' do
        post '/api/v1/groups', params: invalid_member_count

        expect(body).to include_json(error_response)
      end
    end
  end
end
