# frozen_string_literal: true

class JoinUserAnnouncements < ActiveRecord::Migration[7.0]
  def change
    change_table :user_announcements do |t|
      t.references :user, index: true, foreign_key: true
      t.references :announcement, index: true, foreign_key: true
    end
  end
end
