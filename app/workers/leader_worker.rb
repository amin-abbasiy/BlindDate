# frozen_string_literal: true

class LeaderWorker
  include Sidekiq::Worker

  sidekiq_options queue_as :leader

  def perform
    ::Group.where(week: Time.zone.today.cweek).each do |group|
      ActiveRecord::Base.transaction do
        employee = group.accepted_invitations.where(role: 'member').sample.employee
        group.invitations.find_by(employee:)&.update(role: 'leader')
      end
    end
  end
end
