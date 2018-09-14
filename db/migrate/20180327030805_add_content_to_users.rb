class AddContentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :content, :text
  end
end
