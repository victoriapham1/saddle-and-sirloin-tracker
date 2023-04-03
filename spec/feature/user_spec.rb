require 'rails_helper'
require_relative '../login_module'

RSpec.describe('User Features', type: :feature) do
  # User.delete_all
  # Admin.delete_all
  login

  it 'is at member directory' do
    visit users_path
    expect(page).to(have_current_path(users_path))
    expect(page).to(have_content('Member Directory'))
    expect(page).to(have_selector(:link_or_button, 'Search'))
  end

  describe('view user') do
    it 'is able to see profile information' do
      visit edit_user_path(User.find_by(uin: 111_222_333))
      expect(page).to(have_content('Email'))
      expect(page).to(have_content('Events Attendance:'))
    end
  end

  describe('edit user profile') do
    # it 'is unsuccessful' do
    #   visit edit_user_path(User.find_by(uin: 111222333))
    #   fill_in('Phone', with: nil)
    #   expect(page).to(have_selector(:link_or_button, 'Save'))
    #   click_on('Save')
    #   expect(page).to(have_selector(:link_or_button, 'Save')) # Currently, will not redirect to directory.
    # end

    it 'is successful' do
      visit edit_user_path(User.find_by(uin: 111222333))
      fill_in('Phone', with: '2814941234')
      expect(page).to(have_selector(:link_or_button, 'Save'))
      click_on('Save')
      expect(page).to(have_content('281-494-1234'))
    end
  end
end
