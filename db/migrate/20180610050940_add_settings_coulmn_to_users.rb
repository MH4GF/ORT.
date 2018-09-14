# frozen_string_literal: true

class AddSettingsCoulmnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :default_time, :integer, default: 25
    add_column :users, :allow_linked_tweet, :boolean, null: false, default: true
  end
end
