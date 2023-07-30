# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  default from: ENV['DEFAULT_FROM_EMAIL']

  def send_invitation(employee)
    @employee = employee
    mail(to: @employee.email, subject: I18n.t('invitation_mailer.send_invitation.subject'))
  end
end
