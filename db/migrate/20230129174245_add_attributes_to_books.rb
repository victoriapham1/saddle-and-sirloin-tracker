# frozen_string_literal: true

class AddAttributesToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :author, :string
    add_column :books, :price, :decimal
    add_column :books, :publishedDate, :datetime
  end
end
