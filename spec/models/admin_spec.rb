# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Admin, type: :model) do
  describe "sign in" do
    it "runs model functions" do
      click_on('Sign in')
    end
  end
end
