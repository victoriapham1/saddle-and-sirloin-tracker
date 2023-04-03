# frozen_string_literal: true

class Admin < ApplicationRecord
  # created a function that gets the access token
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :events
  def self.from_omniauth(access_token)
    data = access_token.info
    admin = Admin.where(email: data['email']).first

    admin ||= Admin.create!(
      name: data['name'],
      email: data['email'],
      encrypted_password: Devise.friendly_token[0, 20]
    )
    admin
  end

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless email =~ /@tamu.edu\z/ # Ensures only in network (tamu.edu) accounts have access

    # find only would require admins to create new users
    create_with(uid:, full_name:, avatar_url:).find_or_create_by!(email:) # Possibly change to find only
  end
end
