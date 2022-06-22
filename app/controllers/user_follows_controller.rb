# frozen_string_literal: true

class UserFollowsController < ApplicationController
  def followings
    @users = User.find(params[:user_id]).followings.order(:id).page(params[:page])
  end

  def followers
    @users = User.find(params[:user_id]).followers.order(:id).page(params[:page])
  end

  def create
    user_follow = UserFollow.new
    user_follow.followed_id = params[:user_id]
    user_follow.follower_id = current_user.id
    user_follow.save
    redirect_to user_path(user_follow.followed_id)
  end

  def destroy
    UserFollow.find(params[:id]).destroy
    redirect_to user_path(params[:user_id])
  end
end
