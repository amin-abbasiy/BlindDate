# frozen_string_literal: true

class Invitation::Validate
  VALID_PARAMS = %w[id status].freeze

  def initialize(params)
    @params = params
  end

  def call
    @params.slice(:id, :status).each_key do |param|
      raise ActionController::ParameterMissing, message(param) unless VALID_PARAMS.include?(param)
    end
  end

  def message(param)
    "#{param} #{I18n.t('paramrameters.missing')}"
  end
end
