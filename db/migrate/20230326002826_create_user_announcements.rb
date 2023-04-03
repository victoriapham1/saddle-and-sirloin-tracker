# frozen_string_literal: true

class CreateUserAnnouncements < ActiveRecord::Migration[7.0]
  def change
    create_table :user_announcements, &:timestamps
  end
end
