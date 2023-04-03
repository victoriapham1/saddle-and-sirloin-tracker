# frozen_string_literal: true

class AddIsActiveToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :isActive, :boolean, default: true
    drop_table :books
    drop_table :polls
    drop_table :committees
  end
end
