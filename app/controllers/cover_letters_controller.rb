class CoverLettersController < ApplicationController
  before_action :set_cover_letter, only: %i[ show edit update destroy ]

  # GET /cover_letters or /cover_letters.json
  def index
    @cover_letters = CoverLetter.all
  end

  # GET /cover_letters/1 or /cover_letters/1.json
  def show
  end

  # GET /cover_letters/new
  def new
    @cover_letter = CoverLetter.new
  end

  # GET /cover_letters/1/edit
  def edit
  end

  # POST /cover_letters or /cover_letters.json
  def create
    @cover_letter = CoverLetter.new(cover_letter_params)
    @cover_letter.hunter=current_hunter

    respond_to do |format|
      if @cover_letter.save
        # format.js  # Renders create.js.erb
        # format.html { redirect_to @cover_letter, notice: "Cover letter was successfully created." }
        format.json { render :show, status: :created, location: @cover_letter }
      else
        # format.js  # Renders create.js.erb
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @cover_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cover_letters/1 or /cover_letters/1.json
  def update
    respond_to do |format|
      if @cover_letter.update(cover_letter_params)
        format.html { redirect_to @cover_letter, notice: "Cover letter was successfully updated." }
        format.json { render :show, status: :ok, location: @cover_letter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cover_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cover_letters/1 or /cover_letters/1.json
  def destroy
    @cover_letter.soft_delete

    respond_to do |format|
      format.html { redirect_to cover_letters_path, status: :see_other, notice: "Cover letter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cover_letter
      @cover_letter = CoverLetter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def cover_letter_params
      params.expect(cover_letter: [ :subject, :latex_source, :pdf_path ])
    end
end
