require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do

    # Rainy: Fails bc requires all attributes & only have uin.
    it 'ensures users uin' do
      user = User.new(uin: "123456789").save
      expect(user).to eq(false)
    end

    # Rainy: Fails bc requires all attributes & only have first name.
    it 'ensures users first name' do
      user = User.new(first_name: "Pauline").save
      expect(user).to eq(false)
    end

    # Rainy: Fails bc requires all attributes & only have last name.
    it 'ensures users last name' do
      user = User.new(last_name: "Wade").save
      expect(user).to eq(false)
    end

    # Sunny: Passes bc all attributes are filled.
    # TODO: isActive: false --> fails. Why??
    it 'ensures users attributes are filled' do
      user = User.new(uin: "123456789", first_name: "Pauline", last_name: "Wade", email: "pauline.wade@tamu.edu", phone: "1234567890", isActive: true, role: "0", classify: "4").save
      expect(user).to eq(true)
    end

  end
end
