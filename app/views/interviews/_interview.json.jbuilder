json.extract! interview, :id, :job_application_id, :scheduled_date, :result, :mode, :interview_type, :notes, :created_at, :updated_at
json.url interview_url(interview, format: :json)
