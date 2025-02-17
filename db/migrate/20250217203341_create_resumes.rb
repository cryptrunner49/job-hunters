class CreateResumes < ActiveRecord::Migration[8.0]
  def change
    create_table :resumes do |t|
      t.references :hunter, null: false, foreign_key: true
      t.string :title
      t.text :latex_source
      t.string :pdf_path
      t.integer :resume_type

      t.timestamps
    end
  end
end
