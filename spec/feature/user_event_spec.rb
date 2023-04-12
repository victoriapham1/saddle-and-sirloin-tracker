# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('UserEvent', type: :feature) do
  login
  describe 'UserEvent Usability Tests' do
    it 'Loads link to mark attendance' do
      visit '/user_event/50/new'
      expect(page).to(have_current_path('/user_event/50/new'))
      expect(page).to(have_selector(:link_or_button, 'Check in'))
    end

    user = User.create_with(uin: '111222333',
      first_name: 'Tryston', last_name: 'Burriola',
      email: 'trystonburriola@tamu.edu', phone: '5125952682',
      password: 'password', isActive: true, role: 1, classify: 1).find_or_create_by!(email: 'trystonburriola@tamu.edu')

    event = Event.create_with(name: 'testerEvent',
                      description: 'This is the test description.',
                      date: '01-01-2023',
                      event_type: 1,
                      start_time: '9:00',
                      end_time: ' 10:00',google_event_id: '32o3ni4of4g4gh5iuf3gbh309', isActive: true).find_or_create_by!(name: 'testerEvent') 
    
    it 'inputs an invalid uin' do
        visit event_path(Event.find_by(name: "testerEvent").id)
        fill_in 'user_event[user_id]', with: '987654321'
        click_on('Check-in')
        expect(page).to(have_content('Member not found'))
    end

    it 'successfully removes user from an event' do
        visit event_path(Event.find_by(name: "testerEvent").id)
        expect(page).to(have_content('Member'))
        fill_in 'user_event[user_id]', with: '111222333'
        click_on('Check-in')
        click_link ("X")
        expect(page).to(have_content('Attendee removed.'))
    end

    it 'attendance has already been recorded' do
      visit event_path(Event.find_by(name: "testerEvent").id)
      expect(page).to(have_content('Member'))
      fill_in 'user_event[user_id]', with: '111222333'
      click_on('Check-in')
      expect(page).to(have_content('Attendance recorded'))
      fill_in 'user_event[user_id]', with: '111222333'
      click_on('Check-in')
      expect(page).to(have_content('Attendance already recorded'))
    end
  end
end
