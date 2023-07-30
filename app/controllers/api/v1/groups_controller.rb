# frozen_string_literal: true

class Api::V1::GroupsController < ApplicationController
  def index
    @groups = Group.all
    render json: @groups
  end

  def create
    @group = ::Group::Create.new(group_params, self).call

    render json: @group, status: :created
  end

  def week
    @groups = ::Group.weekly_groups(fetch_week[:week])

    render json: @groups
  end

  private

  def group_params
    params.permit(:week, member_ids: [])
  end

  def fetch_week
    params.permit(:week)
  end
end
