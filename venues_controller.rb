class VenuesController < ApplicationController
    before_action :admin_only, except: :index
  
    def index
      venues = Venue.all
      render json: venues
    end
  
    def create
      venue = Venue.new(venue_params)
      if venue.save
        render json: venue, status: :created
      else
        render json: { errors: venue.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      venue = Venue.find(params[:id])
      if venue.update(venue_params)
        render json: venue
      else
        render json: { errors: venue.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      venue = Venue.find(params[:id])
      venue.destroy
      head :no_content
    end
  
    private
  
    def venue_params
      params.require(:venue).permit(:name, :location)
    end
  end
  