# frozen_string_literal: true

class Restaurant < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :groups
  # rubocop:enable Rails/HasManyOrHasOneDependent
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
end
