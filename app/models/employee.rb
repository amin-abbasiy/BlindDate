# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :department
  has_many :invitations, dependent: :destroy
  has_many :groups, through: :invitations

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
end
