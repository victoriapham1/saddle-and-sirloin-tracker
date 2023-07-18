# frozen_string_literal: true

require 'rqrcode'
class Event < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true
  validates :event_type, presence: true
  validates :description, presence: true
  # Because we set Time data type (it includes YYYY-MM-DD, although we only use the time (& seperate date to account for day))
  # When comparing start & end_time together w/o parsing, it will include the unset day, and leads to errors revolving the comparision of start and end date.
  # validates :start_time, comparison: { less_than: :end_time }
  # validates :end_time, comparison: { greater_than: :start_time }
  validate :end_must_be_after_start

  has_many :user_events, dependent: :destroy
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
        named_event = Event.where('name ilike ? AND date >= ?', "%#{search}%",
                                  Time.now.to_date).and(Event.where(isActive: true))
        # if event with  name exists show the events with that name
        @events = if named_event != []
                    # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                    Event.where('name ilike ? AND date >= ?', "%#{search}%",
                                Time.now.to_date).and(Event.where(isActive: true))
                  # if no events with that name exist print all events
                  else
                    Event.where('date >= ?', Time.now.to_date).and(Event.where(isActive: true))
                  end
      else
        @events = Event.where('date >= ?', Time.now.to_date).and(Event.where(isActive: true))
      end
    elsif search
      named_event = Event.where('name ilike ? AND event_type = ? AND date >= ?', "%#{search}%", TYPE[category],
                                Time.now.to_date).and(Event.where(isActive: true))
      # if event with  name exists show the events with that name
      @events = if named_event != []
                  # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                  Event.where('name ilike ? AND event_type = ? AND date >= ?', "%#{search}%", TYPE[category],
                              Time.now.to_date).and(Event.where(isActive: true))
                # if no events with that name exist print all events
                else
                  Event.where('date >= ?', Time.now.to_date).and(Event.where(isActive: true))
                end
    else
      @events = Event.where('date >= ?', Time.now.to_date).and(Event.where(isActive: true))
    end
  end

  def self.prev_search(search, category)
    if category == ''
      if search
        named_event = Event.where('name ilike ?',
                                  "%#{search}%").and(Event.where('date < ?',
                                                                 Time.now.to_date).or(Event.where(isActive: false)))
        # if event with  name exists show the events with that name
        @events = if named_event != []
                    # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                    Event.where('name ilike ?',
                                "%#{search}%").and(Event.where('date < ?',
                                                               Time.now.to_date).or(Event.where(isActive: false)))
                  # if no events with that name exist print all events
                  else
                    Event.where('date < ?', Time.now.to_date).or(Event.where(isActive: false))
                  end
      else
        @events = Event.where('date < ?', Time.now.to_date).or(Event.where(isActive: false))
      end
    elsif search
      named_event = Event.where('name ilike ? AND event_type = ?', "%#{search}%",
                                TYPE[category]).and(Event.where('date < ?',
                                                                Time.now.to_date).or(Event.where(isActive: false)))
      # if event with  name exists show the events with that name
      @events = if named_event != []
                  # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                  Event.where('name ilike ? AND event_type = ?', "%#{search}%",
                              TYPE[category]).and(Event.where('date < ?',
                                                              Time.now.to_date).or(Event.where(isActive: false)))
                # if no events with that name exist print all events
                else
                  Event.where('date < ?', Time.now.to_date).or(Event.where(isActive: false))
                end
    else
      @events = Event.where('date < ?', Time.now.to_date).or(Event.where(isActive: false))
    end
  end

  def qrcode(event_id)
    qr = RQRCode::QRCode.new("#{ENV['URL']}user_event/#{event_id}/new", size = 1)
    qr.as_svg(
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 5,
      standalone: true,
      use_path: true
    )
  end

  # Set page to default of size 10 - will change.
  def self.per_page
    10
  end

  def end_must_be_after_start
    starting = start_time.strftime("%H%M")
    ending = end_time.strftime("%H%M")
    if starting >= ending
      errors.add(:end_time, "must be after start time")
    end
  end
end
