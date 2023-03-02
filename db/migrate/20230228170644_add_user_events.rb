class AddUserEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :user_events do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :attendance

      t.timestamps
    end
  end
end
