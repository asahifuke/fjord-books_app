class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    redirect_to user_path(current_user) unless @user == current_user
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user), notice: 'ユーザーを正常に更新できました'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :address, :zip_code, :introduction)
  end
end
