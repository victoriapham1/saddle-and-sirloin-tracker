# frozen_string_literal: true

class UserAnnouncement < ApplicationRecord
  belongs_to :user
  belongs_to :announcement
end
