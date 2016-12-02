class User < ApplicationRecord
  has_many :events, :foreign_key => 'creator_id', :class_name => "Event"
  has_many :event_attendees, :foreign_key => :attendee_id
  has_many :attended_events, :through => :event_attendees, :source => 'event_attended'
  validates :name, presence: true

  def upcoming_events
    upcoming_events = []
    self.attended_events.each do |event|
      if event.date > Time.now
        upcoming_events << event
      end
    end
    upcoming_events
  end

  def previous_events
    previous_events = []
    self.attended_events.each do |event|
      if event.date < Time.now
        previous_events << event
      end
    end
    previous_events
  end
end
