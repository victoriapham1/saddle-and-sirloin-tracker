require "rqrcode"
class Event < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true
  validates :event_type, presence: true
  validates :description, presence: true
  validates :start_time, presence: false
  validates :end_time, presence: false

  has_many :user_events
  has_many :users, through: :user_events

  TYPE = {
    'Service' => 1,
    'Meeting' => 2,
    'Social' => 3
  }.freeze

  def formatted_type
    TYPE.invert[event_type]
  end

  def self.search(search, category)
    if category == ''
      if search
        named_event = Event.where('name ilike ?', "%#{search}%")
        # if event with  name exists show the events with that name
        @events = if named_event
                    # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                    Event.where('name ilike ?', "%#{search}%")
                  # if no events with that name exist print all events
                  else
                    Event.all
                  end
      else
        @events = Event.all
      end
    elsif search
      named_event = Event.where('name ilike ? AND event_type = ?', "%#{search}%", TYPE[category])
      # if event with  name exists show the events with that name
      @events = if named_event
                  # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                  Event.where('name ilike ? AND event_type = ?', "%#{search}%", TYPE[category])
                # if no events with that name exist print all events
                else
                  Event.all
                end
    else
      @events = Event.all
    end
  end

  def qrcode(event_id)
    qr = RQRCode::QRCode.new("https://testurl.com/" +"user_event/" + "#{event_id}" + "/new")
    svg = qr.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
    return svg
  end
end
