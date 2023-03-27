# frozen_string_literal: true

# OATH
class DashboardsController < ApplicationController
  def show
    # Redirect the user to the create a profile page if
    # the Oauth admin email doesn't exist as a User!
    redirect_to(controller: 'users', action: 'new') if User.find_by(email: current_admin.email).nil?
  end
end
