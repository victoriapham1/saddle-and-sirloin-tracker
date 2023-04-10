# frozen_string_literal: true

class IsReset < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :isReset, :boolean, default: false
  end
end
