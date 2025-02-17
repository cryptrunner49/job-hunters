json.extract! company, :id, :name, :industry, :location, :github, :website, :job_search_website, :description, :created_at, :updated_at
json.url company_url(company, format: :json)
