class CreateJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :job_applications do |t|
      t.references :hunter, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true
      t.references :resume, null: false, foreign_key: true
      t.references :cover_letter, null: false, foreign_key: true
      t.string :status
      t.string :phase
      t.string :mail
      t.datetime :applied_at
      t.text :feedback

      t.timestamps
    end
  end
end
