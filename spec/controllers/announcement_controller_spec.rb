

require 'rails_helper'
require_relative '../login_module' # include to use the login function

RSpec.describe(AnnouncementsController, type: :controller) do
  describe 'GET /' do
    login # RUN THIS LOGIN TO GET PAST OAUTH before tests
    context 'from login admin' do
      it 'returns 200:OK' do
        get :index
        expect(response).to(have_http_status(:success))
      end
    end
  end
end
