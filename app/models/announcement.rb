# frozen_string_literal: true

class Announcement < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :user_announcements, dependent: :destroy
end
