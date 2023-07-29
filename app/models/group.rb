# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :restaurant, optional: true
  has_many :invitations, dependent: :destroy

  has_many :accepted_invitations, -> { where(status: 'accepted') }, class_name: 'Invitation',
                                                                    dependent: :destroy, inverse_of: :group
  has_one :leader, -> { where(role: 'leader') }, class_name: 'Invitation',
                                                 dependent: :destroy, inverse_of: :group
  has_many :members, through: :accepted_invitations, source: :employee

  validates :week, presence: true
end
