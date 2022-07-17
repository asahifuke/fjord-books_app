# frozen_string_literal: true

class BookCommentsController < CommentsController
  def create
    @book = Book.find(params[:book_id])
    super(@book, 'books/show')
  end

  def edit
    @book = Book.find(params[:book_id])
    super
  end

  private

  def redirect
    redirect_to book_path(@comment.commentable_id)
  end
end
