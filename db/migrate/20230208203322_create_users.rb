# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :uin
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :password
      t.boolean :isActive
      t.integer :role
      t.integer :classify

      t.timestamps
    end
  end
end
