

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

               it 'routes to #edit' do
                    expect(get: '/events/1/edit').to(route_to('events#edit', id: '1'))
               end

               it 'routes to #new' do
                    expect(get: '/events/new').to(route_to('events#new'))
               end
          end
     end
end
