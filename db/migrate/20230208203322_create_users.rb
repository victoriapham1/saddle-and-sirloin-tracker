class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, :primary_key =>:user_id do |t|
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
