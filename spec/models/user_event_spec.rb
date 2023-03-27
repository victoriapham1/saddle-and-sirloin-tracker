

require 'rails_helper'

RSpec.describe(UserEvent, type: :model) do
  context 'validation tests' do
    it 'ensures user_id' do
      user_event = described_class.new(event_id: 3, attendance: true).save
      expect(user_event).to(eq(false))
    end

    it 'ensures event_id' do
      user_event = described_class.new(user_id: 1, attendance: true).save
      expect(user_event).to(eq(false))
    end

    it 'ensures attendance' do
      user_event = described_class.new(user_id: 1, event_id: 3).save
      expect(user_event).to(eq(false))
    end
  end

  context 'sunny day' do
    it 'marks attendance for a user that exists in the DB and an event that exists.' do
      user = User.create!(uin: '123456789', first_name: 'Pauline', last_name: 'Wade',
                          email: 'pauline.wade@tamu.edu', phone: '1234567890', isActive: true, role: '0', classify: '4')
      event = Event.create!(name: 'cookout', event_type: 3, date: '12/12/2023',
                            description: 'cookout where you can meet fellow members.')
      user_event = described_class.new(user_id: user.id, event_id: event.id, attendance: true).save

      expect(user_event).to(eq(true))
    end
  end

  context 'rainy day' do
    it 'marks attendance for a user that does not exists in the DB and an event that exists.' do
      user = User.create!(uin: '123456789', first_name: 'Pauline', last_name: 'Wade',
                          email: 'pauline.wade@tamu.edu', phone: '1234567890', isActive: true, role: '0', classify: '4')
      event = Event.create!(name: 'cookout', event_type: 3, date: '12/12/2023',
                            description: 'cookout where you can meet fellow members.')
      user_event = described_class.new(user_id: (user.id + 1), event_id: event.id, attendance: true).save

      expect(user_event).to(eq(false))
    end
  end
end
