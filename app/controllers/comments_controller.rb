# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    if params[:book_id].present?
      book = Book.find(params[:book_id])
      book.comments.create(user_id: current_user.id, body: params[:comment][:body])
      redirect_to book_path(book)
    else
      report = Report.find(params[:report_id])
      report.comments.create(user_id: current_user.id, body: params[:comment][:body])
      redirect_to report_path(report)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    redirect unless current_user == @comment.user
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(body: params[:comment][:body])
    redirect
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect
  end

  private

  def redirect
    case @comment.commentable_type
    when 'Report'
      redirect_to report_path(@comment.commentable_id)
    when 'Book'
      redirect_to book_path(@comment.commentable_id)
    end
  end
end
