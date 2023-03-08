class Committee < ApplicationRecord
  validates :committee_name, presence: true
  validates :description, presence: true
end
