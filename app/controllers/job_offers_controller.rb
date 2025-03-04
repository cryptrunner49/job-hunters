class JobOffersController < ApplicationController
  before_action :set_job_offer, only: %i[show edit update destroy]
  before_action :set_job_application, only: %i[index new create edit update destroy show]

  def index
    @job_offers = @job_application.job_offers.where(deleted: false) # Only show non-deleted offers
  end

  def show
  end

  def new
    @job_offer = @job_application.job_offers.build
  end

  def edit
  end

  def create
    @job_offer = @job_application.job_offers.build(job_offer_params)
    respond_to do |format|
      if @job_offer.save
        format.html { redirect_to job_application_job_offer_path(@job_application, @job_offer), notice: "Job offer was successfully created." }
        format.json { render :show, status: :created, location: @job_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_offer.update(job_offer_params)
        format.html { redirect_to job_application_job_offer_path(@job_application, @job_offer), notice: "Job offer was successfully updated." }
        format.json { render :show, status: :ok, location: @job_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_offer.soft_delete
    respond_to do |format|
      format.html { redirect_to job_application_job_offers_path(@job_application), status: :see_other, notice: "Job offer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
  end

  def set_job_application
    @job_application = JobApplication.find(params[:job_application_id])
  end

  def job_offer_params
    params.require(:job_offer).permit(:status, :salary, :start_date, :offer_date, :message)
  end
end
