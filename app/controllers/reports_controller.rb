# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to reports_path
    else
      render :new
    end
  end

  def show
    @report = Report.find(params[:id])
    @comment = Comment.new
    @comments = @report.comments
  end

  def edit
    @report = Report.find(params[:id])
    redirect_to reports_path unless current_user == @report.user
  end

  def update
    @report = Report.find(params[:id])
    if current_user == @report.user && !@report.update(report_params)
      render :edit
    else
      redirect_to report_path(@report)
    end
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy if current_user == report.user
    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
