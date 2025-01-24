class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events_organized, class_name: "Event", foreign_key: :organizer_id, dependent: :destroy
  has_many :invitations, foreign_key: :attendee_id, dependent: :destroy
  has_many :events_attended, through: :invitations, source: :event

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
end
