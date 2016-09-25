class ReservationsController < ApplicationController
  def add
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.time_end = (@reservation.time_start.to_time + 2.hours).to_datetime
    #@room_number = Room.find_by_sql(["select roomnumber from rooms where id = :rid", {:rid => @reservation.roomid}])
    @room = Room.find(@reservation.roomid)

    #@building = Room.find_by_sql(["select building from rooms where id = :rid", {:rid => @reservation.roomid}])
    if !session[:is_admin]
      @count = Reservation.find_by_sql(["select roomid from reservations where userid = :uid and  time_start >= :st", {:st => (DateTime.now.to_time + 2.hours).to_datetime, :uid => @reservation.userid}])
      if @count.size > 0
        flash[:notice] = "You can only have one active booking at a time "
        redirect_to :controller => 'sessions', :action => 'home'
        return
      end
    end
    if @reservation.save
      render "booking"
      #redirect_to :controller => 'reservations', :action => 'book'
    else
      redirect_to :controller => 'sessions', :action => 'home'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to :controller => 'sessions', :action => 'home'
  end

  def book

  end

  private
  def reservation_params
    params.require(:reservation).permit(:roomid, :time_start, :userid, )
  end
end
