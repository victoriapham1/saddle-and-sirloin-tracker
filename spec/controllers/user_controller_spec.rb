# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe(UsersController, type: :controller) do
  describe 'GET /' do
    context 'prior login' do
      it 'routes to #new' do
        expect(get: '/users/new').to(route_to('users#new'))
      end

      it 'routes to queue' do
        expect(get: '/waiting').to(route_to('users#waiting'))
      end
    end

    login # Pages post-login
    context 'from login' do
      it 'routes to index' do
        get :index
        expect(response).to(have_http_status(:success))
      end

      it 'routes to #edit' do
        expect(get: '/users/1/edit').to(route_to('users#edit', id: '1'))
      end

      it 'routes to activate reset' do
        get :activate_reset
        expect(response).to(have_http_status(:found))
      end

    end
  end

  describe 'President' do
    # Creates both users but logs in the last one as current_admin(President)
    vp_login 
    p_login
    context 'activate_reset'
    it 'routes to activate_reset' do
      get :activate_reset
      expect(response).to(have_http_status(:found))
    end

    # Confirm 2 factor auth condtion!
    it 'routes to confirm' do
      get :confirm
      expect(response).to(have_http_status(:found))
    end

    it 'routes to confirm' do
      # Set condition to route to confirm page
      p = User.find_by(role: 2)
      vp = User.find_by(role: 3)
      p.isReset = true
      vp.isReset = true
      p.save!
      vp.save!

      get :confirm
      expect(response).to(have_http_status(:success))
    end
  end

  describe 'Vice-President' do
    # Creates both users but logs in the last one as current_admin(President)
    p_login
    vp_login
    context 'activate_reset'
    it 'routes to activate_reset' do
      get :activate_reset
      expect(response).to(have_http_status(:found))
    end

    # Confirm 2 factor auth condtion!
    it 'routes to confirm' do
      get :confirm
      expect(response).to(have_http_status(:found))
    end

    it 'routes to confirm' do
      # Set condition to route to confirm page
      p = User.find_by(role: 2)
      vp = User.find_by(role: 3)
      p.isReset = true
      vp.isReset = true
      p.save!
      vp.save!

      get :confirm
      expect(response).to(have_http_status(:success))
    end
  end

end
