# frozen_string_literal: true

class GoogleEventIdToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :google_event_id, :string
  end
end
