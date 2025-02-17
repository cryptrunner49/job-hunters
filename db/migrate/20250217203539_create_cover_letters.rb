class CreateCoverLetters < ActiveRecord::Migration[8.0]
  def change
    create_table :cover_letters do |t|
      t.references :hunter, null: false, foreign_key: true
      t.string :subject
      t.text :latex_source
      t.string :pdf_path

      t.timestamps
    end
  end
end
