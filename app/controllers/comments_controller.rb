# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_up, only: %i[edit update destroy]

  def create(target, render_path)
    @comment = target.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect
    else
      render render_path
    end
  end

  def edit
    redirect unless current_user == @comment.user
  end

  def update
    if @comment.update(comment_params)
      redirect
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy if current_user == @comment.user
    redirect
  end

  private

  def set_up
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
