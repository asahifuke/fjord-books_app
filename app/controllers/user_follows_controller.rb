# frozen_string_literal: true

class UserFollowsController < ApplicationController
  before_action :set_up, only: %i[followings followers]

  def followings
    @users = @user.followings.with_attached_avatar.order(:id).page(params[:page])
  end

  def followers
    @users = @user.followers.with_attached_avatar.order(:id).page(params[:page])
  end

  def create
    user_follow = current_user.active_relationships.new
    user_follow.followed_id = params[:user_id]
    user_follow.save
    redirect_to user_path(user_follow.followed_id)
  end

  def destroy
    UserFollow.find(params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end

  private

  def set_up
    @user = User.find(params[:user_id])
  end
end
