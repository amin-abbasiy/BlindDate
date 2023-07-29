# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :employees, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
