# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('User Features', type: :feature) do
  describe('not logged in') do
    it 'is not able to access site' do
      visit users_path
      expect(current_path).to eq('/admins/sign_in')
      expect(page).to(have_content('You need to sign in or sign up before continuing.'))
    end
  end

  describe('creation of new account') do
    bypass_oauth
    it 'is a new user' do
      User.destroy_all
      User.where(first_name: 'Lisa').destroy_all # Ensure this user does not exist yet
      visit root_path
      expect(current_path).to eq('/users/new')
    end

    it 'cannot access other pages' do
      User.where(first_name: 'Lisa').destroy_all # Ensure this user does not exist yet
      visit waiting_path
      expect(current_path).to eq('/users/new')
    end

    it 'create a new account unsuccessfully' do
      User.where(first_name: 'Lisa').destroy_all # Ensure this user does not exist yet
      visit root_path
      expect(current_path).to eq('/users/new')
      fill_in 'user[first_name]', with: 'Lisa'
      click_on 'Submit'
      expect(page).to(have_content('Last name can\'t be blank'))
    end

    it 'create a new account successfully' do
      User.where(first_name: 'Lisa').destroy_all # Ensure this user does not exist yet
      visit root_path
      fill_in 'user[first_name]', with: 'Lisa'
      fill_in 'user[last_name]', with: 'Tran'
      fill_in 'user[uin]', with: '432000981'
      fill_in 'user[phone]', with: '8321234567'
      click_on 'Submit'
      expect(current_path).to eq('/waiting')
    end
  end

  describe('member logged in') do
    login
    member_login
    it 'is not able to access member directory' do
      visit users_path
      expect(current_path).to eq('/')
    end

    it 'is not able to access other member profile' do
      visit edit_user_path(User.where(first_name: 'Tryston').ids.first)
      expect(current_path).to eq('/')
    end
  end

  describe('officer logged in') do
    login
    it 'is at member directory' do
      visit users_path
      expect(page).to(have_current_path(users_path))
      expect(page).to(have_content('Member Directory'))
      expect(page).to(have_selector(:link_or_button, 'Search'))
    end

    it 'is searching for specific member' do
      visit users_path
      fill_in 'search', with: 'Tryston'
      click_button('Search')
      expect(page).to(have_content('Tryston'))
    end

    it 'is viewing deactive members' do
      visit users_path
      select 'Deactive', from: :category
      click_button('Search')
      expect(page).not_to(have_content('Tryston'))
    end

    it 'is viewing in queue members' do
      visit users_path
      select 'Approval', from: :category
      click_button('Search')
      expect(page).not_to(have_content('Tryston'))
    end

    it 'is denying queue member' do
      # User.where(first_name: 'Lily').destroy_all
      User.where.not(first_name: 'Tryston').destroy_all
      user = User.create_with(uin: '430500123',
                              first_name: 'Pauline', last_name: 'Wade',
                              email: 'paulinewade@tamu.edu', phone: '5125952682',
                              password: 'password', role: 0, classify: 5, isRequesting: true).find_or_create_by!(email: 'paulinewade@tamu.edu')
      visit users_path
      select 'Approval', from: :category
      click_button('Search')
      expect(page).to(have_content('Pauline'))
      check 'user_ids[]'
      click_button('Deny')
      select 'Deactive', from: :category
      click_button('Search')
      expect(page).to(have_content('Pauline'))
    end

    it 'is approving queue member' do
      # User.where(first_name: 'Lily').destroy_all
      User.where.not(first_name: 'Tryston').destroy_all
      user = User.create_with(uin: '430500123',
                              first_name: 'Pauline', last_name: 'Wade',
                              email: 'paulinewade@tamu.edu', phone: '5125952682',
                              password: 'password', role: 0, classify: 5, isRequesting: true).find_or_create_by!(email: 'paulinewade@tamu.edu')
      visit users_path
      select 'Approval', from: :category
      click_button('Search')
      expect(page).to(have_content('Pauline'))
      check 'user_ids[]'
      click_button('Activate')
      expect(page).to(have_content('Pauline'))
    end

    it 'is not able to access the reset' do
      visit activate_reset_path
      expect(current_path).to eq('/')
    end
  end

  describe('view user') do
    login
    it 'is able to see profile information' do
      visit edit_user_path(User.find_by(uin: 111_222_333))
      expect(page).to(have_content('Email'))
      expect(page).to(have_content('Total score'))
    end

    it 'is unable to edit user profile' do
      visit edit_user_path(User.find_by(uin: 111_222_333).id)
      expect(page).to(have_current_path(edit_user_path(User.find_by(uin: 111_222_333).id)))
      fill_in 'user[first_name]', with: 'Tryston123'
      click_button('Save')
      expect(page).to(have_content('error'))
    end

    it 'is able to edit user profile successfully' do
      visit edit_user_path(User.find_by(uin: 111_222_333))
      fill_in('Phone', with: '2814941234')
      expect(page).to(have_selector(:link_or_button, 'Save'))
      click_on('Save')
      visit users_path
      expect(page).to(have_content('281-494-1234'))
    end
  end

  describe('the reset') do
    vp_login
    p_login
    it 'if both p & vp approves reset' do
      p = User.find_by(role: 2)
      vp = User.find_by(role: 3)
      vp.isReset = true
      vp.save!
      visit edit_user_path(p.id)
      click_on('Activate Yearly Reset')
      expect(page).to(have_current_path('/confirm'))
    end
  end

  describe('presidential change') do
    login
    p_login
    it 'if new president' do
      user = User.find_by(role: 1)
      visit edit_user_path(user.id)
      select 'President'
      click_on('Save')
      p = User.find_by(role: 2)
      visit edit_user_path(p.id)
      expect(page).not_to(have_content('Activiate Yearly Reset'))
    end
  end
end
