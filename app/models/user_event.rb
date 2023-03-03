class UserEvent < ApplicationRecord
    validates :user_id, presence: true
    validates :event_id, presence: true
    validates :attendance, presence: true
end
