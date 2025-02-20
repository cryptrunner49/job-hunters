class PreviewsController < ApplicationController
  def create
    latex_source = params[:latex_source]
    pdf_path = generate_pdf(latex_source)

    if pdf_path
      send_file pdf_path, type: "application/pdf", disposition: "inline"
    else
      render plain: "Error generating PDF", status: :unprocessable_entity
    end
  end

  private

  def generate_pdf(latex_source)
    dir = Dir.mktmpdir
    begin
      tex_file = File.join(dir, "preview.tex")
      File.write(tex_file, latex_source)

      system("pdflatex", "-interaction=nonstopmode", "-output-directory", dir, tex_file)

      pdf_file = File.join(dir, "preview.pdf")
      File.exist?(pdf_file) ? pdf_file : nil
    rescue => e
      Rails.logger.error "PDF Generation Error: #{e.message}"
      nil
    end
  end
end
