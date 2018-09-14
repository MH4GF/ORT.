# frozen_string_literal: true

class AddOmniauthColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
  end
end
