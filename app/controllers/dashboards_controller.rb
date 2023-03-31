# OATH
class DashboardsController < ApplicationController
  before_action :authorize_user
  
  def show
    @announcements = Announcement.all
    @user_id = User.find_by(email: current_admin.email).id
  end

  # Creates the 'like' in the UserAnnouncemnent table if it doesn't exist.
  # Otherwise, will perform a 'un-like' to remove the like from the announcment and UA table.
  def like
    uid = like_params[:user_id]
    aid = like_params[:announcement_id]
    user_announcement = UserAnnouncement.find_by(user_id: uid, announcement_id: aid)
    if user_announcement.nil?
      UserAnnouncement.create(user_id: uid, announcement_id: aid)
      redirect_to action: 'show'
    else
      user_announcement.destroy
      redirect_to action: 'show'
    end

    # update_like

  end
  
  def like_params
    params.permit(:user_id, :announcement_id, :like, :not_liked)
  end

  # FIXEME
  def update_like
    render turbo_stream:
      turbo_stream.replace("like",
        partial: "likes",
        locals: like_params) 
  end

  # FOR TESTING! REMOVE
  def swapRole
    @user = User.find_by(email: current_admin.email)
    @user.role = @user.role == 1 ? 0 : 1
    @user.save
    redirect_to '/'
  end

  # Verify User has created thier profile. Redirect to create profile if not
  def authorize_user
    user = User.find_by(email: current_admin.email)
    if user.nil?
      redirect_to(controller: 'users', action: 'new')
    elsif user.isActive == false
      redirect_to(controller: 'users', action: 'waiting')
      user.isRequesting = true
      user.save
    end
  end
  
end
