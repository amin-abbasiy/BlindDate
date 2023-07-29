class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :employee

  enum status: { pending: 0, accepted: 1, rejected: 2 }
  enum role: { member: 0, leader: 1 }
end
