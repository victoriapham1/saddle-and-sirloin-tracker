# frozen_string_literal: true

class AddDescriptionToCommittees < ActiveRecord::Migration[7.0]
  def change
    add_column :committees, :description, :string
  end
end
