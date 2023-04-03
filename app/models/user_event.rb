# frozen_string_literal: true

class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :attendance, presence: true
end
