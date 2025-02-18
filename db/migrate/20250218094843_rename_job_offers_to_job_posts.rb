class RenameJobOffersToJobPosts < ActiveRecord::Migration[8.0]
  def change
    rename_table :job_offers, :job_posts
  end
end
