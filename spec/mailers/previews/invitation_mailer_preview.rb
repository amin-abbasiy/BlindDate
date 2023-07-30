# frozen_string_literal: true

class InvitationMailerPreview < ActionMailer::Preview
  def send_invitation
    employee = Employee.first
    group = Group.first
    invitation = Invitation.create(employee:, group:, role: 'member', status: 'pending')
    InvitationMailer.send_invitation(employee, invitation)
  end
end
