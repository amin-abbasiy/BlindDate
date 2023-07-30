# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  default from: ENV['DEFAULT_FROM_EMAIL']

  def send_invitation(employee, invitation)
    @employee = employee
    @invitation = invitation
    @url = "#{Rails.application.routes.default_url_options[:host]}/api/v1/invitations/#{@invitation.id}"
    mail(to: @employee.email, subject: I18n.t('invitation_mailer.send_invitation.subject'))
  end
end
