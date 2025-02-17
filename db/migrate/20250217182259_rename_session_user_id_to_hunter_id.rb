class RenameSessionUserIdToHunterId < ActiveRecord::Migration[8.0]
  def change
    rename_column :sessions, :user_id, :hunter_id
  end
end
