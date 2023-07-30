# frozen_string_literal: true

class Api::V1::InvitationsController < ApplicationController
  def update
    @invitation = ::Invitation::Update.new(invitation_params).call

    render json: { message: I18n.t('invitation.update') }, status: :ok
  end

  private

  def invitation_params
    params.permit(:id, :status)
  end
end
