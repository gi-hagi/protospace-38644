class UsersController < ApplicationController
  def index
    @name = current_user.name
  end

  def show
    @user = User.find(params[:id])
  end

end
