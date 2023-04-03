# frozen_string_literal: true

class UserDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :isActive, false
  end
end
