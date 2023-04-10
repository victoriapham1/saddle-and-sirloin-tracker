user_events_view_spec.rb
# frozen_string_literal: true

RSpec.describe('UserEvent', type: :feature) do
  login
  describe 'UserEvent Usability Tests' do
    it 'Loads link to mark attendance' do
      visit '/user_event/50/new'
      expect(page).to(have_current_path('/user_event/50/new'))
      expect(page).to(have_selector(:link_or_button, 'Create User event'))
    end
  end
end
