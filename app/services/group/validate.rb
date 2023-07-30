# frozen_string_literal: true

class Group::Validate
  MANDATORY_PARAMS = %w[week member_ids].freeze

  def initialize(params)
    @params = params
  end

  def call
    @params.slice(:week, :member_ids).each_key do |param|
      raise ActionController::ParameterMissing, "#{param} is Missing" unless MANDATORY_PARAMS.include?(param)
    end
  end
end
