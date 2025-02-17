class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :industry
      t.string :location
      t.string :github
      t.string :website
      t.string :job_search_website
      t.text :description

      t.timestamps
    end
  end
end
