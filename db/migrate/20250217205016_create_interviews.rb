class CreateInterviews < ActiveRecord::Migration[8.0]
  def change
    create_table :interviews do |t|
      t.references :job_application, null: false, foreign_key: true
      t.datetime :scheduled_date
      t.string :result
      t.integer :mode
      t.integer :interview_type
      t.text :notes

      t.timestamps
    end
  end
end
