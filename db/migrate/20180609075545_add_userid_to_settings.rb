class AddUseridToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :user_id, :integer
  end
end
