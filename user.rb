class User < ApplicationRecord
  has_secure_password

  has_many :bookings
  has_many :events, through: :bookings

  enum role: { attendee: 'attendee', admin: 'admin' }
end
