# frozen_string_literal: true

class User < ApplicationRecord
  validates :uin, presence: true, uniqueness: true
  validates_format_of :uin, with: /\A[0-9]{9}\Z/

  validates :first_name, presence: true
  validates_format_of :first_name, with: /\A[^0-9!@#$%\^&*+_=]+\z/

  validates :last_name, presence: true
  validates_format_of :last_name, with: /\A[^0-9!@#$%\^&*+_=]+\z/

  validates :email, presence: true
  validates :phone, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }, length: { minimum: 10, maximum: 15 }

  validates :isActive, presence: true, allow_blank: true # Needed to set to false
  validates :role, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 3
  }

  validates :classify, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
  validates :isRequesting, presence: true, allow_blank: true # Needed to set to false

  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  has_many :user_announcements, dependent: :destroy
  has_many :announcements, through: :user_announcements

  # Set page to default of size 10 - will change.
  def self.per_page
    10
  end
end
