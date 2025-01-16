class Event < ApplicationRecord
  belongs_to :venue
  has_many :bookings
  has_many :users, through: :bookings
end
