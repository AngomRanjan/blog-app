class Api::V1::UsersController < ApplicationController
  #before_action :authorize_request
  def index
    @users = User.all
    render json: @users, status: :ok
  end
end
