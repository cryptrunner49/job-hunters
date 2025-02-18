class ChangePostingAndClosingDateToBeNullableInJobPosts < ActiveRecord::Migration[8.0]
  def change
    change_column :job_posts, :posted_at, :date
    change_column :job_posts, :closing_date, :date
    change_column_null :job_posts, :posted_at, true
    change_column_null :job_posts, :closing_date, true
  end
end
