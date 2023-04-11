# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe('Upcoming Event Search', type: :feature) do
  login

  it 'searches by name' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2099',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
    events = Event.search('Tailgate', '')
    expect(events[0].name).to(eq('Tailgate'))
  end

  it 'searches by category' do
    event = Event.new(name: 'Tailgate', event_type: 3, date: '12/12/2099',
                      description: 'cookout where you can meet fellow members.', start_time: Time.now,
                      end_time: Time.now + 2.hours).save
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
    all_events = Event.where('date >= ?', Time.now.to_date).and(Event.where(isActive: true))
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
    all_events = Event.where('date >= ?', Time.now.to_date).and(Event.where(isActive: true))
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
    all_events = Event.where('date < ?', Time.now.to_date).or(Event.where(isActive: false))
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
    all_events = Event.where('date < ?', Time.now.to_date).or(Event.where(isActive: false))
    events = Event.prev_search('xyz', 'Social')

    expect(events).to(eq(all_events))
  end
end
