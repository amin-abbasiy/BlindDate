# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    message = I18n.t('error_messages.unprocessable_entity.message')
    render_json_error(:unprocessable_entity, :unprocessable_entity, 422, message: [message, e.message])
  end

  rescue_from ActiveRecord::RecordNotFound do |_e|
    message = I18n.t('error_messages.record_not_found.message')
    render_json_error(:not_found, :record_not_found, 404, message: [message])
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    message = I18n.t('error_messages.invalid_record.message')
    render_json_error(:unprocessable_entity, :invalid_record, 422, message: [message, e.message])
  end

  rescue_from BlindDateError do |e|
    message = I18n.t('error_messages.form_error.message')
    render_json_error(:unprocessable_entity, :form_error, 422, message: [message, e.message])
  end

  def render_json_error(status, error_class, code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      title: I18n.t("error_messages.#{error_class}.title"),
      status:,
      code: I18n.t("error_messages.#{error_class}.#{code || 'code'}")
    }.merge(extra)

    render json: { errors: [error] }, status:
  end
end
