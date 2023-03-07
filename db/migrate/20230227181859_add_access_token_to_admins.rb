class AddAccessTokenToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :name, :string
    add_column :admins, :access_token, :string
    add_column :admins, :expires_at, :datetime
    add_column :admins, :refresh_token, :string
  end
end
