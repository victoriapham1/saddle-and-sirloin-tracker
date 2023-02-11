require 'rails_helper'

RSpec.describe "Committees", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/committees"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/committees/new"
      expect(response).to have_http_status(:success)
    end
  end

  # describe "GET /edit" do
  #   it "returns http success" do
  #     get "/committees/edit"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
