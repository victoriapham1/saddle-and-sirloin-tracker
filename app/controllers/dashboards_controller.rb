# OATH
class DashboardsController < ApplicationController
  def show
    # Redirect the user to the create a profile page if
    # the Oauth admin email doesn't exist as a User!
    redirect_to(controller: 'users', action: 'new') if User.find_by(email: current_admin.email).nil?
    @announcements = Announcement.all

  end

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
    # SEND THE FORM FOR THIS TO WORK. Key like{ params}
    params.permit(:user_id, :announcement_id)
  end
end
