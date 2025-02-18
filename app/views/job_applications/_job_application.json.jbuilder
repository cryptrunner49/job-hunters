json.extract! job_application, :id, :hunter_id, :job_post_id, :resume_id, :cover_letter_id, :status, :phase, :mail, :applied_at, :feedback, :created_at, :updated_at
json.url job_application_url(job_application, format: :json)
