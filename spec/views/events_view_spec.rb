# frozen_string_literal: true

RSpec.describe('Event', type: :feature) do
  login
  describe 'Event Usability Tests' do
    it 'Loads link to create new event' do
      visit events_path
      expect(page).to have_link('Create new event', href: new_event_path)
    end

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

    # it "Reders edit button for all events" do
    #     visit events_path
    #     expect(page).to have_link("Edit")
    # end
  end
end
