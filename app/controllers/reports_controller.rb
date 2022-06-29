class ReportsController < ApplicationController
  before_action :set_up, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.save
    redirect_to reports_path
  end

  def show
  end

  def edit
  end

  def update
    @report.update(report_params)
    redirect_to report_path(@report)
  end

  def destroy
    @report.destroy
    redirect_to reports_path
  end

  private

  def set_up
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
