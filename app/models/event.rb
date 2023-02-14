class Event < ApplicationRecord
    validates :name, presence: true
    validates :date, presence: true
    validates :event_type, presence: true
    validates :description, presence: true
end
