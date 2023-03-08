require "rails_helper"
require_relative '../login_module'

RSpec.describe UsersController, type: :controller do
    describe "GET /" do
        context "prior login" do
            it 'routes to #new' do
                expect(get: '/users/new').to(route_to('users#new'))
            end
        end
        
        login # Pages post-login
        context "from login" do
            it "routes to index" do
                get :index
                expect(response).to have_http_status(:success)
            end

            it 'routes to #edit' do
                expect(get: '/users/1/edit').to(route_to('users#edit', id: '1'))
            end
        end
    end
end

