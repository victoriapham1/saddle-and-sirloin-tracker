class User < ApplicationRecord
    validates :uin, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :isActive, presence: true
    validates :role, presence: true
    validates :classify, presence: true

    # Set page to default of size 10 - will change.
    def self.per_page
        10
    end
end
