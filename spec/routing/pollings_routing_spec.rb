require "rails_helper"

RSpec.describe PollingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/pollings").to route_to("pollings#index")
    end

    it "routes to #new" do
      expect(get: "/pollings/new").to route_to("pollings#new")
    end

    it "routes to #show" do
      expect(get: "/pollings/1").to route_to("pollings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/pollings/1/edit").to route_to("pollings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/pollings").to route_to("pollings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/pollings/1").to route_to("pollings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/pollings/1").to route_to("pollings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/pollings/1").to route_to("pollings#destroy", id: "1")
    end
  end
end
