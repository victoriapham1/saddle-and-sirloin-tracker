class JoinUserEvents < ActiveRecord::Migration[7.0]
  def change
    remove_columns(:user_events, :user_id, :event_id)
    change_table :user_events do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
    end
  end
end
