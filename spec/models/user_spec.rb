

require 'rails_helper'

RSpec.describe(User, type: :model) do
     subject(:test_user) do
          # Create a new user if currently does not exist
          if User.where(email: 'paulinewade@tamu.edu').first.nil? == true
               User.create!(email: 'paulinewade@tamu.edu', uin: '987654321', first_name: 'Pauline', last_name: 'Wade',
                            phone: '2811234567', password: 'something123', role: '0', classify: '4'
               )
          end
     end

     context 'User attribute(s) validation tests' do
          it 'is valid with all valid attributes' do
               expect(test_user).to(be_valid)
          end

          # Rainy: Fails bc requires all attributes
          it 'ensures all attributes, only users uin' do
               user = User.new(uin: '123456789').save
               expect(user).to(eq(false))
          end

          it 'ensures all attributes, only users first name provided' do
               user = User.new(first_name: 'Pauline').save
               expect(user).to(eq(false))
          end

          it 'ensures all attributes, only users last name provided' do
               user = User.new(last_name: 'Wade').save
               expect(user).to(eq(false))
          end

          it 'ensures all attributes, only users email provided' do
               user = User.new(email: 'paulinewade@tamu.edu').save
               expect(user).to(eq(false))
          end

          it 'ensures all attributes, only users phone provided' do
               user = User.new(email: '2814944785').save
               expect(user).to(eq(false))
          end

          it 'ensures all attributes, only users class classification provided' do
               user = User.new(classify: '0').save
               expect(user).to(eq(false))
          end

          # Sunny: Passes bc all attributes are filled
          it 'ensures users attributes are filled' do
               user = User.new(uin: '123456789', first_name: 'Pauline', last_name: 'Wade',
                               email: 'pauline.wade@tamu.edu', phone: '1234567890', isActive: true, role: '0', classify: '4'
               ).save
               expect(user).to(eq(true))
          end
     end
end
