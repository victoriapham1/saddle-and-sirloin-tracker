# OATH
class DashboardsController < ApplicationController
  def show
    # Redirect the user to the create a profile page if
    # the Oauth admin email doesn't exist as a User!
    user = User.find_by(email: current_admin.email)
    if user.nil?
      redirect_to(controller: 'users', action: 'new')
    elsif user.isActive == false
      redirect_to(controller: 'users', action: 'waiting')
      user.isRequesting = true
      user.save
    end
  
    @announcements = Announcement.all

  end

  # Creates the 'like' in the UserAnnouncemnent table if it doesn't exist.
  # Otherwise, will perform a 'un-like' to remove the like from the announcment and UA table.
  def like
    user_announcement = UserAnnouncement.find_by(like_params)
    if user_announcement == nil
        UserAnnouncement.create(like_params)
        redirect_to :action => 'show'
    else
        user_announcement.destroy
        redirect_to :action => 'show'
    end
  end

  def like_params
    params.permit(:user_id, :announcement_id)

  # FOR TESTING! REMOVE
  def swapRole
    @user = User.find_by(email: current_admin.email)
    @user.role = @user.role == 1 ? 0 : 1
    @user.save
    redirect_to '/'
  end
  
end
