require 'rails_helper'

RSpec.describe "UserEvents", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/user_event/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/user_event/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/user_event/show"
      expect(response).to have_http_status(:success)
    end
  end

end
