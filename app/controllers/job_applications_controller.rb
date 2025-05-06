class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: %i[ show edit update destroy ]

  def index
    @job_applications = JobApplication.where(deleted: false)
  end

  def show
  end

  def new
    @job_application = JobApplication.new
    @resumes = Resume.all
    @cover_letters = CoverLetter.all
  end

  def edit
    @resumes = Resume.where(deleted: false)
    @cover_letters = CoverLetter.where(deleted: false)
  end

  def create
    @job_application = JobApplication.new(job_application_params)
    @resumes = Resume.where(deleted: false)
    @cover_letters = CoverLetter.where(deleted: false)
    @job_application.hunter=current_hunter

    respond_to do |format|
      if @job_application.save
        format.html { redirect_to @job_application, notice: "Job application was successfully created." }
        format.json { render :show, status: :created, location: @job_application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to @job_application, notice: "Job application was successfully updated." }
        format.json { render :show, status: :ok, location: @job_application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_application.soft_delete

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Job application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def job_application_params
      params.expect(job_application: [ :job_post_id, :resume_id, :cover_letter_id, :status, :phase, :mail, :applied_at, :feedback ])
    end
end
