class PreviewsController < ApplicationController
  def create
    safe_filename = SecureRandom.uuid

    latex_source = params[:latex_source]
    pdf_path = generate_pdf(latex_source, safe_filename)

    if pdf_path
      send_file pdf_path, type: "application/pdf", disposition: "inline"
    else
      render plain: "Error generating PDF", status: :unprocessable_entity
    end
  ensure
    CleanupJob.perform_later(pdf_path) # Queue cleanup after serving
  end

  private

  def generate_pdf(latex_source, safe_filename)
    temp_dir = Rails.root.join("tmp", "latex_#{safe_filename}")
    FileUtils.mkdir_p(temp_dir)
    tex_file = temp_dir.join("pdf_preview_#{safe_filename}.tex")
    pdf_file = temp_dir.join("pdf_preview_#{safe_filename}.pdf")

    begin
      File.write(tex_file, latex_source)
      Dir.chdir(temp_dir) do
        system("pdflatex -interaction=nonstopmode pdf_preview_#{safe_filename}.tex")
      end
      pdf_file.to_s
    end
  end
end
