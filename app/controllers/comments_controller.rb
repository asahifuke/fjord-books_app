# frozen_string_literal: true

class CommentsController < ApplicationController
  def update
    @comment.update(comment_params) if current_user == @comment.user
  end

  def destroy
    @comment.destroy if current_user == @comment.user
  end

  private

  def set_up
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
