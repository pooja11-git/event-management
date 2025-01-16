class EventsController < ApplicationController
    before_action :admin_only, except: :index
  
    def index
      events = Event.where(venue_id: params[:venue_id])
      render json: events
    end
  
    def create
      event = Event.new(event_params.merge(venue_id: params[:venue_id]))
      if event.save
        render json: event, status: :created
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      event = Event.find(params[:id])
      if event.update(event_params)
        render json: event
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      event = Event.find(params[:id])
      event.destroy
      head :no_content
    end

    
      def search
        events = Event.all
    
        if params[:date].present?
          events = events.where(date: params[:date])
        end
    
        if params[:venue_id].present?
          events = events.where(venue_id: params[:venue_id])
        end
    
        if params[:min_price].present? && params[:max_price].present?
          events = events.where(price: params[:min_price]..params[:max_price])
        elsif params[:min_price].present?
          events = events.where('price >= ?', params[:min_price])
        elsif params[:max_price].present?
          events = events.where('price <= ?', params[:max_price])
        end
    
        render json: events
      end
  
    private
  
    def event_params
      params.rquire(:event).permit(:name, :date, :price)
    end
  end
  