class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.create(booking_params)
    @venue = Venue.find(params[:venue_id])
    @booking.venue = @venue
    @booking.user = current_user
    if @booking.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def index
  #   @venue = Venue.find(params[:venue_id])
  #   @owner_bookings = Booking.where(@venue.user_id == current_user)
  #   @owner_bookings_pending = @owner_bookings.where status: 0
  # end

  def confirm
    @booking = Booking.find(params[:booking_id])
    @booking.status = 1
  end

  def decline
    @booking = Booking.find(params[:booking_id])
    @booking.status = 2
  end

  private

  def booking_params
    params.require(:booking).permit(:date, current_user)
  end
end
