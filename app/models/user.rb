class User < ApplicationRecord
    validates :uin, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :isActive, presence: true, allow_blank: true
    validates :role, presence: true
    validates :classify, presence: true

    has_many :user_events
    has_many :events, through: :user_events

    # Set page to default of size 10 - will change.
    def self.per_page
        10
    end
end
