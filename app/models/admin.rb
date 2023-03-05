class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :events
  def self.from_omniauth(access_token)
    data = access_token.info
    admin = Admin.where(:email => data["email"]).first

    unless admin
      admin = Admin.create(
            name: data["name"],
            email: data["email"],
            encrypted_password: Devise.friendly_token[0,20]
      )
    end
    admin
  end
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless email =~ /@tamu.edu\z/ #Ensures only in network (tamu.edu) accounts have access
                                                                      #find only would require admins to create new users
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email) #Possibly change to find only
  end

end
