require 'rails_helper'
require_relative '../login_module'

# FIXME: Unable to sign_in @admin
#    NoMethodError:
#      undefined method `sign_in' for #<RSpec::ExampleGroups::Users::GETIndex "returns http success" (./spec/requests/users_spec.rb:7)>

RSpec.describe("Users", type: :request) do
     # describe "GET /index" do
     #   login
     #   it "returns http success" do
     #     get "/users/index"
     #     expect(response).to have_http_status(:success)
     #   end
     # end

     # describe "GET /edit" do
     #   it "returns http success" do
     #     get "/users/edit"
     #     expect(response).to have_http_status(:success)
     #   end
     # end

     # describe "GET /new" do
     #   it "returns http success" do
     #     get "/users/new"
     #     expect(response).to have_http_status(:success)
     #   end
     # end

     # describe "GET /delete" do
     #   it "returns http success" do
     #     get "/users/delete"
     #     expect(response).to have_http_status(:success)
     #   end
     # end

     # describe "GET /show" do
     #   it "returns http success" do
     #     get "/users/show"
     #     expect(response).to have_http_status(:success)
     #   end
     # end

end
