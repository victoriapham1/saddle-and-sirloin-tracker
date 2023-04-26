# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module' # include to use the login function

RSpec.describe(EventsController, type: :controller) do
  describe 'GET /' do
    context 'prior login' do
      it 'routes to #new' do
        expect(get: '/events/new').to(route_to('events#new'))
      end
    end

    login # Pages post-login
    context 'from login' do
      it 'routes to index' do
        get :index
        expect(response).to(have_http_status(:success))
      end

      it 'routes to previous' do
        get :previous, params: { id: 0 }
        expect(response).to(have_http_status(:success))
      end

      it 'routes to edit' do
        event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
                             description: 'cookout where you can meet fellow members.', start_time: Time.zone.now,
                             end_time: Time.zone.now + 2.hours)
        get :edit, params: { id: event.id }
        expect(response).to(have_http_status(:success))
      end

      it 'routes to new' do
        get :new
        expect(response).to(have_http_status(:success))
      end

      # it 'routes to show' do
      #   event = Event.create(name: 'edit test', event_type: 3, date: '12/12/2099',
      #                        description: 'cookout where you can meet fellow members.', start_time: Time.zone.now,
      #                        end_time: Time.zone.now + 2.hours)
      #   get :show, params: { id: event.id }
      #   expect(response).to(have_http_status(:success))
      # end

      # it 'routes to create' do
      #   post :create, params: {"event"=>
      #     {"name"=>"Calendar Test",
      #      "date(1i)"=>"2023",
      #      "date(2i)"=>"4",
      #      "date(3i)"=>"12",
      #      "start_time(1i)"=>"2023",
      #      "start_time(2i)"=>"4",
      #      "start_time(3i)"=>"12",
      #      "start_time(4i)"=>"00",
      #      "start_time(5i)"=>"19",
      #      "end_time(1i)"=>"2023",
      #      "end_time(2i)"=>"4",
      #      "end_time(3i)"=>"12",
      #      "end_time(4i)"=>"02",
      #      "end_time(5i)"=>"19",
      #      "event_type"=>"1",
      #      "description"=>"Testing calendar"},
      #    "commit"=>"Submit"}
      #   expect(response).to(have_http_status(:found))
      # end

      # it 'routes to create and fails' do
      #   post :create, params: {"event"=>
      #     {"name"=>"Calendar Test",
      #      "date(1i)"=>"2023",
      #      "date(2i)"=>"4",
      #      "date(3i)"=>"12",
      #      "start_time(1i)"=>"2023",
      #      "start_time(2i)"=>"4",
      #      "start_time(3i)"=>"12",
      #      "start_time(4i)"=>"00",
      #      "start_time(5i)"=>"19",
      #      "end_time(1i)"=>"2023",
      #      "end_time(2i)"=>"4",
      #      "end_time(3i)"=>"11",
      #      "end_time(4i)"=>"02",
      #      "end_time(5i)"=>"19",
      #      "event_type"=>"1",
      #      "description"=>"Testing calendar"},
      #    "commit"=>"Submit"}
      #   expect(response).to(have_http_status(:unprocessable_entity))
      # end

      # it 'routes to update' do
      #   post :update, params: {"event"=>
      #     {"name"=>"Calendar Test",
      #      "date(1i)"=>"2023",
      #      "date(2i)"=>"4",
      #      "date(3i)"=>"12",
      #      "start_time(1i)"=>"2023",
      #      "start_time(2i)"=>"4",
      #      "start_time(3i)"=>"12",
      #      "start_time(4i)"=>"00",
      #      "start_time(5i)"=>"19",
      #      "end_time(1i)"=>"2023",
      #      "end_time(2i)"=>"4",
      #      "end_time(3i)"=>"12",
      #      "end_time(4i)"=>"02",
      #      "end_time(5i)"=>"19",
      #      "event_type"=>"1",
      #      "description"=>"Testing calendar"},
      #    "commit"=>"Submit"}
      #   expect(response).to(have_http_status(:found))
      # end

      # it 'routes to update and fails' do
      #   post :update, params: {"event"=>
      #     {"name"=>"Calendar Test",
      #      "date(1i)"=>"2023",
      #      "date(2i)"=>"4",
      #      "date(3i)"=>"12",
      #      "start_time(1i)"=>"2023",
      #      "start_time(2i)"=>"4",
      #      "start_time(3i)"=>"12",
      #      "start_time(4i)"=>"00",
      #      "start_time(5i)"=>"19",
      #      "end_time(1i)"=>"2023",
      #      "end_time(2i)"=>"4",
      #      "end_time(3i)"=>"11",
      #      "end_time(4i)"=>"02",
      #      "end_time(5i)"=>"19",
      #      "event_type"=>"1",
      #      "description"=>"Testing calendar"},
      #    "commit"=>"Submit"}
      #   expect(response).to(have_http_status(:unprocessable_entity))
      # end
    end
  end
end
