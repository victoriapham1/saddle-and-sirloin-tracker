# frozen_string_literal: true

# creates or finds a User/Admin to test with and sign_in with Devise
def login
  before do
    User.create_with(uin: '111222333',
                     first_name: 'Tryston', last_name: 'Burriola',
                     email: 'trystonburriola@tamu.edu', phone: '5125952682',
                     password: 'password', isActive: true, role: 1, classify: 1).find_or_create_by!(email: 'trystonburriola@tamu.edu')

    # Need to set to false, as user has access to app already.
    @user = User.find_by(uin: 111_222_333)
    @user.isRequesting = false
    @user.save!

    @admin = Admin.create_with(uid: '1', full_name: 'Tryston Burriola', avatar_url: 'SnS.jfif').find_or_create_by!(email: 'trystonburriola@tamu.edu') # Possibly change to find only

    sign_in(@admin)
  end
end

# Use to test as regular member.
def member_login
  before do
    User.create_with(uin: '333222111',
                     first_name: 'Lily', last_name: 'Zhang',
                     email: 'lilyzhang@tamu.edu', phone: '8321237894',
                     password: 'password', isActive: true, role: 0, classify: 5).find_or_create_by!(email: 'lilyzhang@tamu.edu')

    # Need to set to false, as user has access to app already.
    @user = User.find_by(uin: 333_222_111)
    @user.isRequesting = false
    @user.save!

    @admin = Admin.create_with(uid: '2', full_name: 'Lily Zhang',
                               avatar_url: 'SnS.jfif').find_or_create_by!(email: 'lilyzhang@tamu.edu')

    sign_in(@admin)
  end
end

# Use to test creation of new user.
def bypass_oauth
  before do
    @admin = Admin.create_with(uid: '3', full_name: 'Lisa Tran',
                               avatar_url: 'SnS.jfif').find_or_create_by!(email: 'lisatran@tamu.edu')

    sign_in(@admin)
  end
end
