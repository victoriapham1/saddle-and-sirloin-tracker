class UserEventController < ApplicationController
  # before_action :authorize_user
  def new; end

  def create
    @user_event = UserEvent.new(user_event_params)
    # get user id from uin
    @user = User.where(uin: @user_event.user_id).first
    if @user.nil?
      redirect_to(event_url(@user_event.event_id), notice: 'Member not found')
    else
      @user_event.user_id = @user.id
      @event = Event.where(id: @user_event.event_id)

      respond_to do |format|
        if @user_event.save
          format.html { redirect_to(event_url(@event), notice: 'Attendance recorded') }
          format.json { render(:show, status: :created, location: @event) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @event.errors, status: :unprocessable_entity) }
        end
      end
    end
  end

  def show; end

  def delete
    @user_event = UserEvent.find(params[:id])
    @event = @user_event.event_id
    @user_event.destroy
    redirect_to(event_path(@event), notice: 'Attendee removed.')
  end

  def user_event_params
    params.require(:user_event).permit(:user_id, :event_id, :attendance)
  end
end
