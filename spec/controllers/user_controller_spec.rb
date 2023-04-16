# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module'

RSpec.describe(UsersController, type: :controller) do
  
  test_user = User.create_with(uin: '430500123',
                              first_name: 'Pauline', last_name: 'Wade',
                              email: 'paulinewade@tamu.edu', phone: '5125952682',
                              password: 'password', role: 0, classify: 5).find_or_create_by!(email: 'paulinewade@tamu.edu')

  new_user = User.create_with(uin: '121212121',
                              first_name: 'Lisa', last_name: 'Tran',
                              email: 'lisatran@tamu.edu', phone: '5125952682',
                              password: 'password', role: 0, classify: 1).find_or_create_by!(email: 'lisatran@tamu.edu')
  
  member_user = User.create_with(uin: '333222111',
                                first_name: 'Lily', last_name: 'Zhang',
                                email: 'lilyzhang@tamu.edu', phone: '8321237894',
                                password: 'password', isActive: true, role: 0, classify: 5).find_or_create_by!(email: 'lilyzhang@tamu.edu')

  describe 'GET user routes' do

    context 'prior login' do
      it 'index blocks route' do
        get :index
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'new blocks route' do
        get :new
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'create blocks route' do
        get :create, params: { uin: test_user.uin, first_name: test_user.first_name, last_name: test_user.last_name, email: test_user.email, phone: test_user.phone, password: test_user.password, role: test_user.role, classify: test_user.classify }
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'edit blocks route' do
        get :edit, params: { id: test_user.id }
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'update blocks route' do
        get :update, params: { id: test_user.id }
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'waiting block route' do
        get :waiting
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'faq block route' do
        get :faq
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'confirm reset block route' do
        get :confirm
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'reset block route' do
        get :reset
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
    end

    context 'as new user' do
      bypass_oauth
      it 'index blocks route' do
        get :index
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'new route' do
        expect(get: '/users/new').to(route_to('users#new'))
      end
      it 'create route' do
        post :create, params: { 'user' => { uin: new_user.uin, first_name: new_user.first_name, last_name: new_user.last_name, phone: new_user.phone, classify: new_user.classify }, 'commit' => 'Submit' }
        expect(response).to(have_http_status(:found))
      end
      it 'edit blocks route' do
        get :edit, params: { id: new_user.id }
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'update blocks route' do
        get :update, params: { id: new_user.id }
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'waiting route' do
        post :create, params: { 'user' => { uin: new_user.uin, first_name: new_user.first_name, last_name: new_user.last_name, phone: new_user.phone, classify: new_user.classify }, 'commit' => 'Submit' }
        get :waiting
        expect(response).to(have_http_status(200))
      end
      it 'faq block route' do
        get :faq
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'confirm reset block route' do
        get :confirm
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'reset block route' do
        get :reset
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
    end

    context 'post login as member' do
      member_login
      it 'index blocks route' do
        get :index
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'new blocks route' do
        get :new
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'create blocks route' do
        post :create, params: { 'user' => { uin: member_user.uin, first_name: member_user.first_name, last_name: member_user.last_name, phone: member_user.phone, classify: member_user.classify }, 'commit' => 'Submit' }
        expect(response).to(have_http_status(:found))
      end
      it 'edit route' do
        get :edit, params: { id: User.find_by(uin: 333222111).id }
        expect(response).to(have_http_status(200))
      end
      it 'update route' do
        patch :update, params: { 'user' => { uin: member_user.uin, first_name: "Lilly", last_name: member_user.last_name, phone: member_user.phone, classify: member_user.classify }, 'commit' => 'Submit', 'id' => member_user.id }
        expect(response).to(have_http_status(:found)) # Successfully saved & redirected.
      end
      it 'waiting block route' do
        get :waiting
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'faq route' do
        get :faq
        expect(response).to(have_http_status(200))
      end
      it 'confirm reset block route' do
        get :confirm
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'reset block route' do
        get :reset
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
    end

    context 'post login as officer' do
      login
      it 'index route' do
        get :index
        expect(response).to(have_http_status(:success))
      end
      it 'edit route' do
        get :edit, params: { id: User.find_by(uin: 333222111).id }
        expect(response).to(have_http_status(200))
      end
      it 'update route' do
        patch :update, params: { 'user' => { uin: member_user.uin, first_name: "Lilly", last_name: member_user.last_name, phone: member_user.phone, classify: member_user.classify }, 'commit' => 'Submit', 'id' => member_user.id }
        expect(response).to(have_http_status(:found)) # Successfully saved & redirected.
      end
      it 'confirm reset block route' do
        get :confirm
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
      it 'reset block route' do
        get :reset
        expect(response).to(have_http_status(:found)) # 302 indicated redirect!
      end
    end

    context 'post login as president' do

    end
  end
end
  
 
#   describe 'GET /' do
#     context 'prior login' do
#       it 'routes to #new' do
#         expect(get: '/users/new').to(route_to('users#new'))
#       end

#       it 'routes to queue' do
#         expect(get: '/waiting').to(route_to('users#waiting'))
#       end
#     end

#     login # Pages post-login
#     context 'from login' do
#       it 'routes to index' do
#         get :index
#         expect(response).to(have_http_status(:success))
#       end

#       it 'routes to #edit' do
#         expect(get: '/users/1/edit').to(route_to('users#edit', id: '1'))
#       end
#     end
#   end
# end

#   describe 'Announcement Routes post login' do
#     login # RUN THIS LOGIN TO GET PAST OAUTH before tests
#     context 'from login' do
#       it 'index returns 200:OK' do
#         get :index
#         expect(response).to(have_http_status(:success))
#       end
#       it 'new returns 200:OK' do
#         get :new
#         expect(response).to(have_http_status(:success))
#       end

#       it 'create returns 302' do
#         post :create,
#              params: { 'announcement' => { 'title' => test.title, 'description' => test.description },
#                        'commit' => 'Submit' }
#         expect(response).to(have_http_status(:found))
#       end
#       it 'create returns 422' do
#         post :create,
#              params: { 'announcement' => { 'title' => '', 'description' => test.description }, 'commit' => 'Submit' }
#         expect(response).to(have_http_status(:unprocessable_entity))
#       end
#       it 'create returns 422' do
#         post :create, params: { 'announcement' => { 'title' => test.title, 'description' => '' }, 'commit' => 'Submit' }
#         expect(response).to(have_http_status(:unprocessable_entity))
#       end

#       it 'edit returns 200:OK' do
#         get :edit, params: { id: test.id }
#         expect(response).to(have_http_status(:success))
#       end

#       it 'update returns 302' do
#         patch :update,
#               params: { 'announcement' => { 'title' => test.title, 'description' => test.description }, 'commit' => 'Submit',
#                         'id' => test.id }
#         expect(response).to(have_http_status(:found))
#       end
#       it 'update returns 422' do
#         patch :update,
#               params: { 'announcement' => { 'title' => '', 'description' => test.description }, 'commit' => 'Submit',
#                         'id' => test.id }
#         expect(response).to(have_http_status(:unprocessable_entity))
#       end
#       it 'update returns 422' do
#         patch :update,
#               params: { 'announcement' => { 'title' => test.title, 'description' => '' }, 'commit' => 'Submit',
#                         'id' => test.id }
#         expect(response).to(have_http_status(:unprocessable_entity))
#       end

#       it 'delete returns 200:OK' do
#         get :delete, params: { id: test.id }
#         expect(response).to(have_http_status(:success))
#       end
#       it 'destroy returns 302' do
#         get :destroy, params: { id: test.id }
#         expect(response).to(have_http_status(:found))
#       end
#       it 'show returns 200:OK' do
#         get :show, params: { id: test.id }
#         expect(response).to(have_http_status(:success))
#       end
#     end
#   end
