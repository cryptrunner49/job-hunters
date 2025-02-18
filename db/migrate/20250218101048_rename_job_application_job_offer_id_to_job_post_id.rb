class RenameJobApplicationJobOfferIdToJobPostId < ActiveRecord::Migration[8.0]
  def change
    rename_column :job_applications, :job_offer_id, :job_post_id
  end
end
