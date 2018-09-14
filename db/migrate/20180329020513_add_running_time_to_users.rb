class AddRunningTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :running_time, :integer
  end
end
