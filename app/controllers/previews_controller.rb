class PreviewsController < ApplicationController
  require "shellwords"

  def create
    latex_source = sanitize_latex(params[:latex_source], params[:type])
    if latex_source.blank? || latex_source.size > 10.megabytes # Max 10MB
      render plain: "LaTeX  to big, limit 10MB.", status: :unprocessable_entity
      return
    end

    random_id = SecureRandom.uuid
    pdf_path = generate_pdf(latex_source, random_id)
    if pdf_path
      # brakeman is dumb this code is safe, the parameter :latex_source is not being used in the filename
      # and is sanitized in the sanitize_latex function
      send_file pdf_path, type: "application/pdf", disposition: "inline"
    else
      render plain: "Error generating PDF", status: :unprocessable_entity
    end
  ensure
    CleanupJob.perform_later(pdf_path) # Queue cleanup after serving
  end

  private

  def generate_pdf(latex_source, random_id)
    temp_dir = Rails.root.join("tmp", "latex_#{random_id}")
    FileUtils.mkdir_p(temp_dir, mode: 0700)
    tex_path = "pdf_preview_#{random_id}.tex"
    tex_file = temp_dir.join(tex_path)
    pdf_file = temp_dir.join("pdf_preview_#{random_id}.pdf")

    begin
      File.write(tex_file, latex_source)
      Dir.chdir(temp_dir) do
        system("timeout 200 xelatex -interaction=nonstopmode -no-shell-escape #{Shellwords.escape(tex_path)}")
      end
      pdf_file.to_s
    rescue
      nil
    end
  end

  def sanitize_latex(latex_source, type)
    sanitized = latex_source.dup

    # Remove explicitly dangerous commands that trigger external execution
    dangerous_patterns = [
      /\\write18\s*\{.*?\}/m,             # external shell commands
      /\\(input|include)\s*\{.*?\}/m,      # including external files
      /\\openout\d*\s*\{.*?\}/m,           # writing to files
      /\\read\s*\{.*?\}/m,                # reading from files
      /\\catcode\s*\S+/m,                 # altering category codes
      /\\csname\s+.*?\\endcsname/m,        # constructing commands dynamically
      /\\def\s+\\[a-zA-Z@]+.*?{/m,         # defining new macros
      /\\newcommand\s*\*?\s*\\[a-zA-Z@]+\s*(\[[^\]]*\])?\s*\{.*?\}/m,
      /\\renewcommand\s*\*?\s*\\[a-zA-Z@]+\s*(\[[^\]]*\])?\s*\{.*?\}/m,
      /\\usepackage\s*\{.*?\}/m,           # loading additional packages
      /\\documentclass\s*\{.*?\}/m        # forcing a different document class
    ]
    dangerous_patterns.each do |pattern|
      sanitized.gsub!(pattern, "")
    end

    # TODO: Make more secure using allowed list instead of a blocklist
    # Allowed list as needed for your application.
    # allowed_commands = %w[
    #  begin end textbf textit emph section subsection subsubsection paragraph
    #  subparagraph itemize enumerate description item math displaymath align
    #  \usepackage{hyperref} \usepackage[yyyymmdd]{datetime} \usepackage{comment}
    # ]
    # Remove any commands (i.e. sequences starting with \) not in the whitelist.
    # sanitized.gsub!(/\\([a-zA-Z@]+)/) do |cmd|
    #  command = Regexp.last_match(1)
    #  allowed_commands.include?(command) ? cmd : ""
    # end
    #

    if type == "resume" then
      default_resume_packages = [
        "\\documentclass[12pt]{article}",
        "\\n",
        "\\usepackage[margin=1in]{geometry}",
        "\\n",
        "\\usepackage{fontspec}"
     ].join
     default_resume_packages + "\n" + sanitized
    else
      default_cover_letter_packages = [
        "\\documentclass[12pt]{letter}",
        "\\n",
        "\\usepackage[margin=1in]{geometry}",
        "\\n",
        "\\usepackage{fontspec}"
      ].join
      default_cover_letter_packages + "\n" + sanitized
    end
  end
end
