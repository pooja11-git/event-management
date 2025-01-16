class BookingsController < ApplicationController
  
    def create
      booking = current_user.bookings.new(event_id: params[:event_id])
      if booking.save
        render json: booking, status: :created
      else
        render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def index
      if current_user.admin?
        bookings = Booking.all
      else
        bookings = current_user.bookings
      end
      render json: bookings
    end
  
    def update
      booking = Booking.find(params[:id])
      booking.update(status: params[:status])
      render json: booking
    end
  
    def destroy
      booking = Booking.find(params[:id])
      booking.destroy
      head :no_content
    end
  
    def approve
      change_status('approved')
    end
  
    def reject
      change_status('rejected')
    end
  
    private
  
    def change_status(new_status)
      booking = Booking.find(params[:id])
      booking.update(status: new_status)
      render json: booking
    end
  end
  