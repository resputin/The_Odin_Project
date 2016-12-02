class Event < ApplicationRecord
  belongs_to :creator, :class_name => "User"
  has_many :event_attendees, :foreign_key => :event_attended_id
  has_many :attendees, :through => :event_attendees, :source => :attendee
  validates :date, presence: true

  scope :past, -> { where('date < ?', Time.now) }
  scope :upcoming, -> { where('date > ?', Time.now) }
end
