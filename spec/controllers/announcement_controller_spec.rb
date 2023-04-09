# frozen_string_literal: true

require 'rails_helper'
require_relative '../login_module' # include to use the login function

RSpec.describe(AnnouncementsController, type: :controller) do
  test = Announcement.create_with(title: "Test Announcement!", description: "This is the test description!").find_or_create_by(title: "Test Announcement!")

  describe 'Announcement Routes' do
    context 'prior login' do
      it 'index blocks route' do 
        get :index
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'new blocks route' do 
        get :new
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'create blocks route' do 
        get :create, params: {title: test.title, description: test.description}
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'edit blocks route' do 
        get :edit, params: {id: test.id}
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'update blocks route' do 
        get :update, params: {id: test.id}
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'delete blocks route' do 
        get :delete, params: {id: test.id}
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'destroy blocks route' do 
        get :destroy, params: {id: test.id}
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
      it 'show blocks route' do 
        get :show, params: {id: test.id}
        expect(response).to(have_http_status(:found)) #302 indicated redirect!
      end
    end
  end
  
  describe 'Announcement Routes post login' do
    login # RUN THIS LOGIN TO GET PAST OAUTH before tests  
    context 'from login' do
      it 'index returns 200:OK' do
        get :index
        expect(response).to(have_http_status(:success))
      end
      it 'new returns 200:OK' do
        get :new
        expect(response).to(have_http_status(:success))
      end

      it 'create returns 302' do
        post :create, params: {"announcement"=>{"title"=>test.title, "description"=>test.description}, "commit"=>"Submit"}
        expect(response).to(have_http_status(:found))
      end
      it 'create returns 422' do
        post :create, params: {"announcement"=>{"title"=>"", "description"=>test.description}, "commit"=>"Submit"}
        expect(response).to(have_http_status(:unprocessable_entity))
      end
      it 'create returns 422' do
        post :create, params: {"announcement"=>{"title"=>test.title, "description"=>""}, "commit"=>"Submit"}
        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it 'edit returns 200:OK' do
        get :edit, params: {id: test.id}
        expect(response).to(have_http_status(:success))
      end

      it 'update returns 302' do
        patch :update, params: {"announcement"=>{"title"=>test.title, "description"=>test.description}, "commit"=>"Submit", "id"=>test.id}
        expect(response).to(have_http_status(:found))
      end
      it 'update returns 422' do
        patch :update, params: {"announcement"=>{"title"=>"", "description"=>test.description}, "commit"=>"Submit", "id"=>test.id}
        expect(response).to(have_http_status(:unprocessable_entity))
      end
      it 'update returns 422' do
        patch :update, params: {"announcement"=>{"title"=>test.title, "description"=>""}, "commit"=>"Submit", "id"=>test.id}
        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it 'delete returns 200:OK' do
        get :delete, params: {id: test.id}
        expect(response).to(have_http_status(:success))
      end
      it 'destroy returns 302' do
        get :destroy, params: {id: test.id}
        expect(response).to(have_http_status(:found))
      end
      it 'show returns 200:OK' do
        get :show, params: {id: test.id}
        expect(response).to(have_http_status(:success))
      end
    end
  end
end

