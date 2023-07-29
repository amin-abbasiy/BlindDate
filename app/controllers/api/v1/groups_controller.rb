# frozen_string_literal: true

class Api::V1::GroupsController < ApplicationController
  def index
    @groups = Group.all
    render json: @groups
  end
end
