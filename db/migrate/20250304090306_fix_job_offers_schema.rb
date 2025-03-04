class FixJobOffersSchema < ActiveRecord::Migration[8.0]
  def change
    # Remove redundant columns
    remove_column :job_offers, :hunter_id, :integer
    remove_column :job_offers, :job_post_id, :integer
    remove_column :job_offers, :company_id, :integer

    # Add job_application_id if not already present
    unless column_exists?(:job_offers, :job_application_id)
      add_reference :job_offers, :job_application, null: false, foreign_key: true
    end
  end
end
