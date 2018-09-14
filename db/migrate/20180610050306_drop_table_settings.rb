# frozen_string_literal: true

class DropTableSettings < ActiveRecord::Migration[5.1]
  def change
    drop_table :settings
  end
end
