# frozen_string_literal: true

class Invitation::Update
  def initialize(params)
    Invitation::Validate.new(params).call
    @invitation_id = params[:id]
    @status = params[:status]
  end

  def call
    find_invitation
    @invitation.update!(status: @status)

    @invitation
  end

  def find_invitation
    @invitation = Invitation.find(@invitation_id)
    @group = Group.find_by(id: @invitation.group_id, week: Time.zone.today.cweek)
    raise ActiveRecord::RecordNotFound, I18n.t('invitation.expired') if @group.nil?
  end

  private

  attr_reader :invitation
end
