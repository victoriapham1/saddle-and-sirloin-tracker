#creates or finds a User/Admin to test with and sign_in with Devise
def login
    before :each do
        User.create_with(uin: "111222333",
            first_name: "Tryston", last_name: "Burriola",
            email: "trystonburriola@tamu.edu", phone: "5125952682",
            password: "password", isActive: true, role: 0, classify: 1).find_or_create_by!(email: "trystonburriola@tamu.edu")

        @admin = Admin.create_with(uid: "1", full_name: "Tryston Burriola", avatar_url: "SnS.jfif").find_or_create_by!(email: "trystonburriola@tamu.edu") #Possibly change to find only


        sign_in @admin
    end
end
