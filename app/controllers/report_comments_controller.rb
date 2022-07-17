# frozen_string_literal: true

class ReportCommentsController < CommentsController
  def create
    @report = Report.find(params[:report_id])
    super(@report, 'reports/show')
  end

  def edit
    @report = Report.find(params[:report_id])
    super
  end

  private

  def redirect
    redirect_to report_path(@comment.commentable_id)
  end
end
