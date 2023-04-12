# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe(UserEventController, type: :controller) do
  login
  describe 'UserEventuser_event_params' do
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

    ua = UserEvent.find_by(user_id: user.id, event_id: event.id)
    
    ua&.destroy

    # Rainy
    it 'Sunny day: creates user event and seen in table' do
      post :create, params: {"user_event"=>{"attendance"=>"true", "event_id"=>event.id, "user_id"=>user.id}, "commit"=>"Create User event", "event_id"=>event.id, "id"=>"2"}
      expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).not_to eq(nil)
    end
    it 'Sunny day: creates user event' do
        post :create, params: {"user_event"=>{"attendance"=>"true", "event_id"=>event.id, "user_id"=>user.id}, "commit"=>"Create User event", "event_id"=>event.id, "id"=>"2"}
        expect(response).to(have_http_status(:found))
      end
    it 'rainy day: creates user event but attendance false' do
        #expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).to eq(nil)
        post :create, params: {"user_event"=>{"attendance"=>"false", "event_id"=>event.id, "user_id"=>user.id}, "commit"=>"Create User event", "event_id"=>event.id, "id"=>"2"}
        expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).to eq(nil)
       # puts "UA id: " + UserEvent.find_by(user_id: user.id, event_id: event.id).event_id.to_s
      end


#     it 'no event param' do
#       expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).to eq(nil)
#       get :user_event_params, params: { user_id: user.id, event_id: nil }
#       expect(controller.params[:user_id]).not_to eq(nil)
#       expect(controller.params[:event_id]).to eq('')
#       expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).to eq(nil)
#     end

#     # Sunny
#     it 'creates UserEvent join through get route' do
#       expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).to eq(nil)
#       get :user_event_params, params: { user_id: user.id, event_id: event.id }
    #   expect(controller.params[:user_id]).not_to eq(nil)
    #   expect(controller.params[:event_id]).not_to eq(nil)
    #   expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).not_to eq(nil)
#     end

#     it 'destroys UserEvent join through get route' do
#       UserEvent.create(user_id: user.id, event_id: event.id)
#       expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).not_to eq(nil)
#       get :user_event_params, params: { user_id: user.id, event_id: event.id }
#       expect(controller.params[:user_id]).not_to eq(nil)
#       expect(controller.params[:event_id]).not_to eq(nil)
#       expect(UserEvent.find_by(user_id: user.id, event_id: event.id)).to eq(nil)
#     end
   end
 end
