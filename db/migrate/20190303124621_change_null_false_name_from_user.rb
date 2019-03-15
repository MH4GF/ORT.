class ChangeNullFalseNameFromUser < ActiveRecord::Migration[5.2]
  def up
    change_column_null :users, :name, false
  end

  def down
    change_column_null :users, :name, true
  end
end
