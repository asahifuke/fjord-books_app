# frozen_string_literal: true

class BookCommentsController < CommentsController
  before_action :set_up, only: %i[edit update destroy]

  def create
    book = Book.find(params[:book_id])
    book.comments.new(comment_params).store(current_user)
    redirect_to book_path(book)
  end

  def edit
    redirect unless current_user == @comment.user
  end

  def update
    super && redirect
  end

  def destroy
    super && redirect
  end

  private

  def redirect
    redirect_to book_path(@comment.commentable_id)
  end
end
