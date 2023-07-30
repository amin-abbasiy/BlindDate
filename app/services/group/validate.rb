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

    allowed_number_of_members?
  end

  private

  def allowed_number_of_members?
    raise ::BlindDateError, I18n.t('error_messages.group_number_message') unless efficient_members?
  end

  def efficient_members?
    @params[:member_ids].uniq.count.between?(3, 5)
  end
end
