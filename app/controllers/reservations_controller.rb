class ReservationsController < ApplicationController
  def add
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.time_end = (@reservation.time_start.to_time + 2.hours).to_datetime
    if !session[:is_admin]
      @count = Reservation.find_by_sql(["select roomid from reservations where userid = :uid and  time_start >= :st", {:st => (DateTime.now.to_time + 2.hours).to_datetime, :uid => @reservation.userid}])
      if @count.size > 0
        flash[:notice] = "You can only have one active booking at a time "
        redirect_to :controller => 'sessions', :action => 'home'
        return
      end
    end
    if @reservation.save
      redirect_to :controller => 'sessions', :action => 'home'
    else
      redirect_to :controller => 'sessions', :action => 'home'
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:roomid, :time_start, :userid)
  end
end
