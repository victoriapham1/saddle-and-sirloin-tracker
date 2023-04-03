require 'rails_helper'

RSpec.describe(User, type: :model) do
  subject(:test_user) do
    # Create a new user if currently does not exist
    if User.where(email: 'paulinewade@tamu.edu').first.nil? == true
      User.create!(email: 'paulinewade@tamu.edu', uin: '987654321', first_name: 'Pauline', last_name: 'Wade',
                   phone: '2811234567', password: 'password', role: '0', classify: '4')
    end
  end

  context 'User attribute(s) validation tests' do
    it 'is valid with all valid attributes' do
      expect(test_user).to(be_valid)
    end

    it 'ensures all attributes, only users uin provided' do
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

    it 'ensures all attributes, only users classification provided' do
      user = User.new(classify: '0').save
      expect(user).to(eq(false))
    end
  end

  # TODO:
  # UIN validation tests
  context 'when UIN' do
    it 'is NOT valid without uin' do
      test_user.uin = nil
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with too long number' do
      test_user.uin = '43780001202'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with too short number' do
      test_user.uin = '4378000'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid without numerical value' do
      test_user.uin = 'howdy123'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with negative value' do
      test_user.uin = '-4320007142'
      expect(test_user).not_to(be_valid)
    end

    it 'is valid uin' do
      test_user.uin = '432000714'
      expect(test_user).to(be_valid)
    end
  end

  # First name validation tests
  context 'when FIRST NAME' do
    it 'is NOT valid without name' do
      test_user.first_name = nil
      expect(test_user).not_to(be_valid)
    end

    it 'is valid with space' do
      test_user.first_name = 'Mary Ann'
      expect(test_user).to(be_valid)
    end

    it 'is valid with dash' do
      test_user.first_name = 'Mary-Ann'
      expect(test_user).to(be_valid)
    end

    it 'is valid with an `' do
      test_user.first_name = 'El\' Salvador'
      expect(test_user).to(be_valid)
    end

    it 'is NOT valid with @' do
      test_user.first_name = 'P@ham'
      expect(test_user).not_to(be_valid)
    end
  end

  # Last name validation tests
  context 'when LAST NAME' do
    it 'is NOT valid without last name' do
      test_user.last_name = nil
      expect(test_user).not_to(be_valid)
    end

    it 'is valid with space' do
      test_user.last_name = 'Le Gomez'
      expect(test_user).to(be_valid)
    end

    it 'is valid with dash' do
      test_user.last_name = 'Jones-Smith'
      expect(test_user).to(be_valid)
    end

    it 'is valid with an `' do
      test_user.last_name = 'El\' Salvador'
      expect(test_user).to(be_valid)
    end

    it 'is NOT valid with +' do
      test_user.last_name = 'P+ham'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with @' do
      test_user.last_name = 'P@ham'
      expect(test_user).not_to(be_valid)
    end
  end

  # Phone number validation tests
  context 'when PHONE' do
    it 'is NOT valid without number' do
      test_user.phone = nil
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with too long number' do
      test_user.phone = '8323022244578123'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with too short number' do
      test_user.phone = '832302'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid without numerical value' do
      test_user.phone = 'howdy123'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with negative value' do
      test_user.phone = '-8323024782'
      expect(test_user).not_to(be_valid)
    end

    it 'is valid number' do
      test_user.phone = '8323024782'
      expect(test_user).to(be_valid)
    end
  end

  # Role validation tests
  context 'when ROLE' do
    it 'is NOT valid without number' do
      test_user.role = nil
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with larger enumeration of 3' do
      test_user.role = '4'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with smaller enumeration of 0' do
      test_user.role = '-1'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid without numerical value' do
      test_user.role = 'howdy123'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with negative value' do
      test_user.role = '-8323024782'
      expect(test_user).not_to(be_valid)
    end

    it 'is valid member role' do
      test_user.role = '0'
      expect(test_user).to(be_valid)
    end

    it 'is valid officer role' do
      test_user.role = '1'
      expect(test_user).to(be_valid)
    end

    it 'is valid president role' do
      test_user.role = '2'
      expect(test_user).to(be_valid)
    end

    it 'is valid vice-president role' do
      test_user.role = '3'
      expect(test_user).to(be_valid)
    end
  end

  # Classification validation tests
  context 'when CLASSIFY' do
    it 'is NOT valid without number' do
      test_user.classify = nil
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid without numerical value' do
      test_user.classify = 'howdy'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with larger enumeration of 5' do
      test_user.classify = '6'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with smaller enumeration of 1' do
      test_user.classify = '0'
      expect(test_user).not_to(be_valid)
    end

    it 'is NOT valid with negative value' do
      test_user.classify = '-8323024782'
      expect(test_user).not_to(be_valid)
    end

    it 'is valid freshmen classification' do
      test_user.classify = '1'
      expect(test_user).to(be_valid)
    end

    it 'is valid sophomore classification' do
      test_user.classify = '2'
      expect(test_user).to(be_valid)
    end

    it 'is valid junior classification' do
      test_user.classify = '3'
      expect(test_user).to(be_valid)
    end

    it 'is valid senior classification' do
      test_user.classify = '4'
      expect(test_user).to(be_valid)
    end

    it 'is valid graduate classification' do
      test_user.classify = '5'
      expect(test_user).to(be_valid)
    end
  end

end