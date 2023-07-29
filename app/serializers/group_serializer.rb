# frozen_string_literal: true

class GroupSerializer < ActiveModel::Serializer
  type 'group'
  attributes :id, :week
  has_many :members do
    object.members.map do |member|
      {
        email: member.email,
        position: member.position,
        department: member.department.name
      }
    end
  end

  belongs_to :restaurant do
    {
      name: object.restaurant.name,
      address: object.restaurant.address,
      phone_number: object.restaurant.phone_number
    }
  end

  has_one :leader do
    {
      email: object.leader&.employee&.email,
      position: object.leader&.employee&.position,
      department: object.leader&.employee&.department&.name
    }
  end
end
