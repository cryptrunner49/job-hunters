class AddInfoToResumes < ActiveRecord::Migration[8.0]
  def change
    add_column :resumes, :hunter_name, :string
    add_column :resumes, :hunter_address, :string
    add_column :resumes, :hunter_phone, :string
    add_column :resumes, :hunter_mail, :string
    add_column :resumes, :hunter_urls, :string
    add_column :resumes, :hunter_summary, :string
    add_column :resumes, :hunter_experience, :string
    add_column :resumes, :hunter_education, :string
    add_column :resumes, :hunter_skill, :string
    add_column :resumes, :hunter_projects, :string
  end
end
