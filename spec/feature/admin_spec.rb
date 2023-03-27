# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('Oauth', type: :feature) do
  describe 'Not logged in' do
    it 'root page redirects to Sign in if not signed in' do
      visit root_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'users#index redirects to Sign in if not signed in' do
      visit users_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'users#new redirects to Sign in if not signed in' do
      visit new_user_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'events#index redirects to Sign in if not signed in' do
      visit events_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'events#new redirects to Sign in if not signed in' do
      visit new_event_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'announcements#index redirects to Sign in if not signed in' do
      visit announcements_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'announcements#new redirects to Sign in if not signed in' do
      visit new_announcement_path
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'calendar#index redirects to Sign in if not signed in' do
      visit '/calendar'
      expect(page).to(have_current_path(new_admin_session_path))
      expect(page).to(have_content('You need to sign in or sign up before continuing'))
      expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end
  end

  describe 'logged in' do
    login # POST LOGIN

    it 'root page when signed in' do
      visit root_path
      expect(page).to(have_current_path(root_path))
      expect(page).to(have_content('You\'re logged in!'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'users#index when signed in' do
      visit users_path
      expect(page).to(have_current_path(users_path))
      expect(page).to(have_content('Member Directory'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'users#new when signed in' do
      visit new_user_path
      expect(page).to(have_current_path(users_path))
      expect(page).to(have_content('Member Directory'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'events#index when signed in' do
      visit events_path
      expect(page).to(have_current_path(events_path))
      expect(page).to(have_content('Events'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'events#new when signed in' do
      visit new_event_path
      expect(page).to(have_current_path(new_event_path))
      expect(page).to(have_content('New Event'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'announcements#index when signed in' do
      visit announcements_path
      expect(page).to(have_current_path(announcements_path))
      expect(page).to(have_content('Announcement'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'announcements#new when signed in' do
      visit new_announcement_path
      expect(page).to(have_current_path(new_announcement_path))
      expect(page).to(have_content('New announcement'))
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end

    it 'calendar#index when signed in' do
      visit '/calendar'
      expect(page).to(have_current_path('/calendar'))
      # expect(page).to(have_content('Embed Example')) #NEEDS TO BE THE CALENDAR NAME
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end
    it 'calendar in the right time zone' do
      visit '/calendar'
      expect(page).to(have_current_path('/calendar'))
      expect(page).to(have_content('Justin Chai')) # NEEDS TO BE THE CALENDAR NAME
      # expect(page).to(have_selector(:link_or_button, 'Sign in'))
    end
  end
end
