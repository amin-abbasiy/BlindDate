# frozen_string_literal: true

class Group::Create
  def initialize(params, _callback)
    ::Group::Validate.new(params).call
    @week = params[:week]
    @member_ids = params[:member_ids]
  end

  def call
    ActiveRecord::Base.transaction do
      @group = ::Group.create!(week: @week)
      @member_ids.each do |member_id|
        employee = ::Employee.find(member_id)
        @group.invitations.create(employee:, group: @group, status: :pending)
      end
    end

    @group
  end

  private

  attr_reader :group
end
