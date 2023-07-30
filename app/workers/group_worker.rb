# frozen_string_literal: true

class GroupWorker
  include Sidekiq::Worker

  sidekiq_options queue_as :group

  def perform
    Employee.all.shuffle.each_slice(4) do |employees|
      ActiveRecord::Base.transaction do
        @group = Group.create!(week: Time.zone.today.cweek)
        employees.each do |employee|
          @group.invitations.create!(role: 'member', status: 'pending', employee:)
        end

        send_emails
      end
    end
  end

  def send_emails
    @group.invitations.each do |invitation|
      InvitationMailer.send_invitation(invitation.employee, invitation).deliver_now
    end
  end
end
