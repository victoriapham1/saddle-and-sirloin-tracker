# frozen_string_literal: true

class AddDescriptionAgain < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :description, :string
  end
end
