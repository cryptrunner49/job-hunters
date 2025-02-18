class AddDeletedToAllTables < ActiveRecord::Migration[8.0]
  def change
    # Add soft delete column to each table with a default value of false
    add_column :hunters, :deleted, :boolean, default: false, null: false
    add_column :companies, :deleted, :boolean, default: false, null: false
    add_column :roles, :deleted, :boolean, default: false, null: false
    add_column :job_posts, :deleted, :boolean, default: false, null: false
    add_column :resumes, :deleted, :boolean, default: false, null: false
    add_column :cover_letters, :deleted, :boolean, default: false, null: false
    add_column :job_applications, :deleted, :boolean, default: false, null: false
    add_column :interviews, :deleted, :boolean, default: false, null: false
    add_column :job_offers, :deleted, :boolean, default: false, null: false
  end
end
