class AddAssociationsToEventAttendees < ActiveRecord::Migration[5.0]
  def change
    add_reference :event_attendees, :attendee, foreign_key: true
    add_reference :event_attendees, :event_attended, foreign_key: true
  end
end
