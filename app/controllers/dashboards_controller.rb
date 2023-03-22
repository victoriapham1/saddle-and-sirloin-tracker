# OATH
class DashboardsController < ApplicationController
  def show
    # Redirect the user to the create a profile page if
    # the Oauth admin email doesn't exist as a User!
    redirect_to(controller: 'users', action: 'new') if User.find_by(email: current_admin.email).nil?
  end

  #FOR TESTING! REMOVE
  def swapRole
    @user = User.find_by(email: current_admin.email)
    @user.role = @user.role == 1 ? 0 : 1
    @user.save
    redirect_to '/'
  end
end
