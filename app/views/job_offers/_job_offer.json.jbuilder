json.extract! job_offer, :id, :hunter_id, :job_post_id, :company_id, :status, :salary, :start_date, :offer_date, :message, :created_at, :updated_at
json.url job_offer_url(job_offer, format: :json)
