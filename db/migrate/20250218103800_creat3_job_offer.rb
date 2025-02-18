class Creat3JobOffer < ActiveRecord::Migration[8.0]
  def change
    create_table :job_offers do |t|
      t.references :hunter, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :status
      t.decimal :salary
      t.date :start_date
      t.date :offer_date
      t.text :message

      t.timestamps
    end
  end
end
