# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Event, type: :model) do
  context 'validation tests' do
    it 'ensures event name' do
      event = Event.new(event_type: 3, date: '12/12/2023',
                        description: 'cookout where you can meet fellow members.').save
      expect(event).to(eq(false))
    end

    it 'ensures event date' do
      event = Event.new(event_type: 3, name: 'Cookout',
                        description: 'cookout where you can meet fellow members.').save
      expect(event).to(eq(false))
    end

    # #ensures the date for the event is after the day the event was created.
    # #ensures the date is of the format DD/MM/YYYY (or change it so it has to be MM/DD/YYYY)

    it 'ensures event description' do
      event = Event.new(event_type: 3, date: '12/12/2012', name: 'Cookout').save
      expect(event).to(eq(false))
    end

    it 'ensrues event type' do
      event = Event.new(name: 'Cookout', date: '12/12/2012',
                        description: 'cookout where you can meet fellow members.').save
      expect(event).to(eq(false))
    end
  end
end
