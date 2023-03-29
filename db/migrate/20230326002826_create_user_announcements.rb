class CreateUserAnnouncements < ActiveRecord::Migration[7.0]
  def change
    create_table :user_announcements do |t|
      t.timestamps
    end
  end
end
