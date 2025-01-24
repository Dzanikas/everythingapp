class Event < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee

  validates :name, :location, :time, presence: true
end
