json.extract! resume, :id, :hunter_id, :title, :latex_source, :pdf_path, :resume_type, :created_at, :updated_at
json.url resume_url(resume, format: :json)
