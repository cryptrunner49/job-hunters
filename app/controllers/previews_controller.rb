class PreviewsController < ApplicationController
  require "shellwords"

  def create
    latex_source = sanitize_latex(params[:latex_source], params[:type])
    if latex_source.blank? || latex_source.size > 10.megabytes # Max 10MB
      render plain: "LaTeX  to big, limit 10MB.", status: :unprocessable_entity
      return
    end
    template_string = %Q{\\documentclass[12pt]{article}
\\usepackage[margin=1in]{geometry}
\\usepackage{fontspec}
\\setmainfont{Arial}
\\setlength{\\parindent}{0pt}

\\begin{document}

\\begin{center}
    {\\LARGE \\textbf{#{current_hunter.name}}}\\\\[0.5em]
    1234 Main Street, City, State, ZIP $\\vert$ (123) 456-7890 $\\vert$ john.doe@example.com $\\vert$ linkedin.com/in/johndoe\\\\[0.5em]
\\end{center}

\\section*{Professional Summary}
Results-driven professional with over 5 years of experience in software development. Skilled in Python, Java, and C++.

\\section*{Experience}
\\textbf{Senior Software Engineer} \\hfill 2020-02-01 -- 2023-01-01\\
Tech Solutions Inc., New York, NY\\
Led the design and development of scalable applications.

\\vspace{0.5em}
\\textbf{Software Developer} \\hfill 2017-06-01 -- 2020-01-01\\
Innovative Apps LLC, San Francisco, CA\\
Developed web applications and maintained legacy systems.

\\section*{Education}
\\textbf{Bachelor of Science in Computer Science} \\hfill 2017-05-01\\
State University, City, State

\\section*{Skills}
Python, Java, C++ \\quad | \\quad Django, React, Angular \\quad | \\quad Git, Docker, AWS

\\section*{Projects}
\\textbf{Inventory Management System} \\hfill 2021-03-01 -- 2021-11-01\\
Streamlined supply chain operations reducing overhead by 15\\%.

\\end{document}
}

    random_id = SecureRandom.uuid
    pdf_path = generate_pdf(template_string, random_id)
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
