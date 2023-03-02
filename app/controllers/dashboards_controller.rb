#OATH
class DashboardsController < ApplicationController
    def show
      #Redirect the user to the create a profile page if 
      #the Oauth admin email doesn't exist as a User!
      if User.find_by(email: current_admin.email) == nil
        redirect_to :controller => 'users', :action => 'new'
      end
    end
  end
