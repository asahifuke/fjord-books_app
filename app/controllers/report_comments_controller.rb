# frozen_string_literal: true

class ReportCommentsController < CommentsController
  before_action :set_up, only: %i[edit update destroy]

  def create
    report = Report.find(params[:report_id])
    report.comments.new(comment_params).store(current_user)
    redirect_to report_path(report)
  end

  def edit
    @report = Report.find(params[:report_id])
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
    redirect_to report_path(@comment.commentable_id)
  end
end
