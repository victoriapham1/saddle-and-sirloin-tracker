# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('Upcoming Event Search', type: :feature) do
  login

  it 'searches by name' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2099',
                      description: 'cookout where you can meet fellow members.', start_time: Time.zone.now,
                      end_time: Time.zone.now + 2.hours).save
    events = Event.search('Tailgate', '')
    expect(events[0].name).to(eq('Tailgate'))
  end

  it 'searches by category' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2099',
                      description: 'cookout where you can meet fellow members.', start_time: Time.zone.now,
                      end_time: Time.zone.now + 2.hours).save
    events = Event.search('', 'Social')
    expect(events[0].event_type).to(eq(3))
  end

  it 'returns all events if no event has searched name (w/o category)' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2099',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    event2 = Event.new(name: 'cookout', event_type: 2, date: '08/12/2099',
                       description: 'cookout where you can meet fellow members.', start_time: Time.now,
                       end_time: Time.now + 2.hours).save
    all_events = Event.where('date >= ?', Time.now.in_time_zone('Central Time (US & Canada)').to_date).and(Event.where(isActive: true))
    events = Event.search('xyz', '')

    expect(events).to(eq(all_events))
  end

  it 'returns all events if no event has searched name (w/ category)' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2099',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    event2 = Event.new(name: 'cookout', event_type: 2, date: '08/12/2099',
                       description: 'cookout where you can meet fellow members.', start_time: Time.now,
                       end_time: Time.now + 2.hours).save
    all_events = Event.where('date >= ?', Time.now.in_time_zone('Central Time (US & Canada)').to_date).and(Event.where(isActive: true))
    events = Event.search('xyz', 'Social')

    expect(events).to(eq(all_events))
  end
end

RSpec.describe('Previous Event Search', type: :feature) do
  login

  it 'searches by name' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2013',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    events = Event.prev_search('Tailgate', '')
    expect(events[0].name).to(eq('Tailgate'))
  end

  it 'searches by category' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2013',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    events = Event.prev_search('', 'Social')
    expect(events[0].event_type).to(eq(3))
  end

  it 'returns all events if no event has searched name (w/o category)' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2013',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    event2 = Event.new(name: 'cookout', event_type: 2, date: '08/12/2013',
                       description: 'cookout where you can meet fellow members.', start_time: Time.now,
                       end_time: Time.now + 2.hours).save
    all_events = Event.where('date < ?', Time.now.in_time_zone('Central Time (US & Canada)').to_date).or(Event.where(isActive: false))
    events = Event.prev_search('xyz', '')

    expect(events).to(eq(all_events))
  end

  it 'returns all events if no event has searched name (w/ category)' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2023',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    event2 = Event.new(name: 'cookout', event_type: 2, date: '08/12/2023',
                       description: 'cookout where you can meet fellow members.', start_time: Time.now,
                       end_time: Time.now + 2.hours).save
    all_events = Event.where('date < ?', Time.now.in_time_zone('Central Time (US & Canada)').to_date).or(Event.where(isActive: false))
    events = Event.prev_search('xyz', 'Social')

    expect(events).to(eq(all_events))
  end
end

RSpec.describe('Event Views', type: :feature) do
  describe 'Event Usability Tests' do
    login
    it 'Loads button to view previous events' do
      visit events_path
      expect(page).to have_button('Previous Events')
    end

    it 'Loads search bar to search for events' do
      visit events_path
      expect(page).to have_field('search')
    end

    it 'Loads filter for event types' do
      visit events_path
      expect(page).to have_field('category')
    end

    it 'Loads search button for event search' do
      visit events_path
      expect(page).to have_button('Search')
    end
  end

  describe 'Sunny Day' do
    login

    it 'Officers can see delete button on page' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      visit events_path
      expect(page).to have_link('Delete')
    end

    it 'Officers can manually add attendees to event' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      user = User.create_with(uin: '111222333',
                              first_name: 'Tryston', last_name: 'Burriola',
                              email: 'trystonburriola@tamu.edu', phone: '5125952682',
                              password: 'password', isActive: true, role: 1, classify: 1).find_or_create_by!(email: 'trystonburriola@tamu.edu')
      user_event = UserEvent.create(event_id: event.id, user_id: user.id)
      visit event_path(event.id)
      expect(page).to have_button('Check-in')
    end

    it 'Officers can show QR code for members to scan' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      visit event_path(event.id)
      expect(page).to have_selector('svg')
    end

    it 'Officers can create a new event' do
      visit events_path
      expect(page).to have_link('Create new event', href: new_event_path)
    end

    it 'Officers can see attendance sheet' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      user = User.create_with(uin: '111222333',
                              first_name: 'Tryston', last_name: 'Burriola',
                              email: 'trystonburriola@tamu.edu', phone: '5125952682',
                              password: 'password', isActive: true, role: 1, classify: 1).find_or_create_by!(email: 'trystonburriola@tamu.edu')
      user_event = UserEvent.create(event_id: event.id, user_id: user.id, attendance: true)
      visit event_path(event.id)
      expect(page).to have_table('attendance table')
    end
  end

  describe 'Rainy Day' do
    member_login
    it 'Members can not see delete button on page' do
      visit events_path
      expect(page).not_to have_link('Delete')
    end

    it 'Members can not  manually add attendees to event' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      visit event_path(event.id)
      expect(page).not_to have_button('Check-in')
    end

    it 'Members can not show QR code for members to scan' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      visit event_path(event.id)
      expect(page).not_to have_selector('svg')
    end

    it 'Members can not create a new event' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      visit events_path
      expect(page).not_to have_link('Create new event', href: new_event_path)
    end

    it 'Members can not see attendance sheet' do
      event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                           description: 'cookout where you can meet fellow members.', start_time: Time.now,
                           end_time: Time.now + 2.hours)
      user = User.create_with(uin: '111222333',
                              first_name: 'Tryston', last_name: 'Burriola',
                              email: 'trystonburriola@tamu.edu', phone: '5125952682',
                              password: 'password', isActive: true, role: 1, classify: 1).find_or_create_by!(email: 'trystonburriola@tamu.edu')
      user_event = UserEvent.create(event_id: event.id, user_id: user.id, attendance: true)
      visit event_path(event.id)
      expect(page).not_to have_table('attendance table')
    end
  end
end
