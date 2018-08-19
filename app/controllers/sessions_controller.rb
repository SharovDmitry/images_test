class SessionsController < ApplicationController
  include SessionsDoc

  skip_before_action :check_auth_token

  def create
    user = User.create
    render json: user, status: :ok
  end
end
