json.extract! job_offer, :id, :title, :description, :skills_required, :experience, :location, :relocation, :apply_from_anywhere, :remote, :english_level, :japanese_level, :salary, :employment_type, :posted_at, :closing_date, :company_id, :role_id, :created_at, :updated_at
json.url job_offer_url(job_offer, format: :json)
