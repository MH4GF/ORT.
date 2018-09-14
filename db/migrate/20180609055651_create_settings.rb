# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.integer :default_time, default: 25
      t.boolean :linked_tweet, null: false, default: true

      t.timestamps
    end
  end
end
