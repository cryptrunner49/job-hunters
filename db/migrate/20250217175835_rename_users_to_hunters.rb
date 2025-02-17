class RenameUsersToHunters < ActiveRecord::Migration[8.0]
  def change
    rename_table :users, :hunters
  end
end
