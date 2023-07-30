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

  private

  def group_params
    params.permit(:week, member_ids: [])
  end
end
