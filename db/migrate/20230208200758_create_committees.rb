# frozen_string_literal: true

class CreateCommittees < ActiveRecord::Migration[7.0]
  def change
    create_table :committees do |t|
      t.string :committee_name

      t.timestamps
    end
  end
end
