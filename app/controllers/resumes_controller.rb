class ResumesController < ApplicationController
  before_action :set_resume, only: %i[ show edit update destroy ]

  # GET /resumes or /resumes.json
  def index
    @resumes = Resume.all
  end

  # GET /resumes/1 or /resumes/1.json
  def show
  end

  # GET /resumes/new
  def new
    @resume = Resume.new
  end

  # GET /resumes/1/edit
  def edit
  end

  # POST /resumes or /resumes.json
  def create
    @resume = Resume.new(resume_params)
    @resume.hunter=current_hunter

    respond_to do |format|
      if @resume.save
        # format.js  # Renders create.js.erb
        # format.html { redirect_to @resume, notice: "Resume was successfully created." }
        format.json { render :show, status: :created, location: @resume }
      else
        # format.js   # Renders create.js.erb with errors
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resumes/1 or /resumes/1.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to @resume, notice: "Resume was successfully updated." }
        format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1 or /resumes/1.json
  def destroy
    @resume.soft_delete

    respond_to do |format|
      format.html { redirect_to resumes_path, status: :see_other, notice: "Resume was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resume
      @resume = Resume.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def resume_params
      params.expect(resume: [ :title, :resume_type, :hunter_name, :hunter_address, :hunter_phone, :hunter_mail, :hunter_urls, :hunter_summary, :hunter_experience, :hunter_education, :hunter_skill, :hunter_projects ])
    end
end
