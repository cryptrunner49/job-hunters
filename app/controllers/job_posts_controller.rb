class JobPostsController < ApplicationController
  before_action :set_job_post, only: %i[ show edit update destroy ]

  def index
    @job_posts = JobPost.where(deleted: false)
  end

  def show
  end

  def new
    @job_post = JobPost.new
    @companies = Company.where(deleted: false)
    @roles = Role.where(deleted: false)
  end

  def edit
    @companies = Company.where(deleted: false)
    @roles = Role.where(deleted: false)
  end

  def create
    @job_post = JobPost.new(job_post_params)
    @companies = Company.where(deleted: false)
    @roles = Role.where(deleted: false)

    if @job_post.company_id.blank? || @job_post.role_id.blank?
      @job_post.errors.add(:base, "Please select both a company and a role.")
    end

    respond_to do |format|
      if @job_post.save
        format.html { redirect_to @job_post, notice: "Job post was successfully created." }
        format.json { render :show, status: :created, location: @job_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_post.update(job_post_params)
        format.html { redirect_to @job_post, notice: "Job post was successfully updated." }
        format.json { render :show, status: :ok, location: @job_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_post.soft_delete

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Job post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_post
      @job_post = JobPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_post_params
      params.require(:job_post).permit(:title, :description, :skills_required, :experience, :location, :relocation, :apply_from_anywhere, :remote, :english_level, :japanese_level, :salary, :employment_type, :posted_at, :closing_date, :company_id, :role_id)
    end
end
