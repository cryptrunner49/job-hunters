class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[show edit update destroy]
  before_action :set_job_application, only: %i[index new create edit update destroy show]

  def index
    @interviews = @job_application.interviews
  end

  def show
  end

  def new
    @interview = @job_application.interviews.build
  end

  def edit
  end

  def create
    @interview = @job_application.interviews.build(interview_params)
    respond_to do |format|
      if @interview.save
        format.html { redirect_to job_application_interview_path(@job_application, @interview), notice: "Interview was successfully created." }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to job_application_interview_path(@job_application, @interview), notice: "Interview was successfully updated." }
        format.json { render :show, status: :ok, location: @interview }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interview.soft_delete
    respond_to do |format|
      format.html { redirect_to job_application_interviews_path(@job_application), status: :see_other, notice: "Interview was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def set_job_application
    @job_application = JobApplication.find(params[:job_application_id])
  end

  def interview_params
    params.require(:interview).permit(:scheduled_date, :result, :mode, :interview_type, :notes)
  end
end
