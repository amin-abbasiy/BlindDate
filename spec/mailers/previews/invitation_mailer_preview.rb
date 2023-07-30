# frozen_string_literal: true

class InvitationMailerPreview < ActionMailer::Preview
  def send_invitation
    employee = Employee.first
    InvitationMailer.send_invitation(employee)
  end
end
