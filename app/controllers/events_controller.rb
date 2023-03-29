require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'
class EventsController < ApplicationController
  CALENDAR_ID = 'primary'.freeze
  before_action :authorize_user
  before_action :block_member, except: %i[index show]
  helper_method :sort_column, :sort_direction

  # GET /events or /events.json
  def index
    @events = Event.all
    # @events = Event.search(params[:search])
    @events = Event.search(params[:search], params[:category])
  end

  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
    @user_event = UserEvent.new
    @users = User.order(sort_column + ' ' + sort_direction)
    @count_users = 0
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # gets the current client that is logged in right now with all of its tokens and information
  def get_google_calendar_client(current_admin)
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless current_admin.present? && current_admin.access_token.present? && current_admin.refresh_token.present?

    secrets = Google::APIClient::ClientSecrets.new({
                                                     'web' => {
                                                       'access_token' => current_admin.access_token,
                                                       'refresh_token' => current_admin.refresh_token,
                                                       'client_id' => ENV['GOOGLE_OAUTH_CLIENT_ID'],
                                                       'client_secret' => ENV['GOOGLE_OAUTH_CLIENT_SECRET']
                                                     }
                                                   })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = 'refresh_token'

      if current_admin.blank?
        client.authorization.refresh!
        current_admin.update(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: Integer(client.authorization.expires_at, 10)
        )
      end
    rescue StandardError => e
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to(:back)
    end
    client
  end

  # POST /events or /events.json
  # syncs the events made to the calendar
  def create
    client = get_google_calendar_client(current_admin)
    task = params[:event]
    event = get_event(task)
    ge = client.insert_event('primary', event)
    params[:event][:google_event_id] = ge.id
    flash[:notice] = 'Event was successfully added.'
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to(event_url(@event), notice: 'Event was successfully created.') }
        format.json { render(:show, status: :created, location: @event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to(event_url(@event), notice: 'Event was successfully updated.') }
        format.json { render(:show, status: :ok, location: @event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    client = get_google_calendar_client(current_admin)

    @event = Event.find(params[:id])
    client.delete_event('primary', @event[:google_event_id])
    @event.destroy

    redirect_to(events_path, notice: 'Event was successfully destroyed.')
  end

  private

  # creates a google calendar event with all of the required fill ins from the events table.
  def get_event(task)
    # puts task[:start_time].inspect

    event = Google::Apis::CalendarV3::Event.new(
      summary: task[:name],
      location: '275 Joe Routt Blvd, College Station, TX 77840',

      description: task[:description],
      start: {
        date_time: Time.zone.local(task['date(1i)'], task['date(2i)'], task['date(3i)'], task['start_time(4i)'], task['start_time(5i)'],
                                   0o0).to_datetime,
        time_zone: '+6:00'
        # date_time: '2019-09-07T09:00:00-07:00',
        # time_zone: 'Asia/Kolkata',
      },
      end: {
        date_time: Time.zone.local(task['date(1i)'], task['date(2i)'], task['date(3i)'], task['end_time(4i)'], task['end_time(5i)'],
                                   0o0).to_datetime,
        time_zone: '+6:00'
      }, primary: true
    )
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :date, :event_type, :description, :start_time, :end_time, :search,
                                  :google_event_id, user_ids: [])
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

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'first_name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  # URL protection: don't allow members to view officer pages/actions
  def block_member
    return unless User.find_by(email: current_admin.email).role == 0

    redirect_to '/'
  end
end
