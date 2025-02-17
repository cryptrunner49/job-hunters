class CreateJobOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :job_offers do |t|
      t.string :title
      t.text :description
      t.string :skills_required
      t.string :experience
      t.string :location
      t.boolean :relocation
      t.boolean :apply_from_anywhere
      t.integer :remote
      t.integer :english_level
      t.integer :japanese_level
      t.decimal :salary
      t.integer :employment_type
      t.datetime :posted_at
      t.datetime :closing_date
      t.references :company, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
