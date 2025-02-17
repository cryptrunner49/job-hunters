class AddPhoneToHunters < ActiveRecord::Migration[8.0]
  def change
    add_column :hunters, :phone, :string
  end
end
