# frozen_string_literal: true

class AddTimesEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :start_time, :time, null: true
    add_column :events, :end_time, :time, null: true
  end
end
