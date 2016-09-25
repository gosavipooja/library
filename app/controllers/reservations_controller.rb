class ReservationsController < ApplicationController
  def add
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.time_end =  (@reservation.time_start.to_time + 2.hours).to_datetime
    if @reservation.save
      redirect_to :controller => 'sessions', :action => 'home'
    else
      redirect_to  :controller => 'sessions', :action => 'home'
    end
  end
  private
  def reservation_params
    params.require(:reservation).permit(:roomid, :time_start, :userid)
  end
end
