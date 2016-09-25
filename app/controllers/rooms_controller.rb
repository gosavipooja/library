class RoomsController < ApplicationController

  def index
    if session[:user_id]
      @rooms = Room.all
    else
      redirect_to :action => "login", :controller => "sessions"
    end

  end

  def show
    @room = Room.find(params[:id])
    @reservations = Reservation.find_by_sql(["select * from reservations where roomid = :id desc", {:id => params[:id] }])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  def add
    @room = Room.new
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room
    else
      render 'add'
    end
  end

  def update
    @room = Room.find(params[:id])

    if @room.update(room_params)

      redirect_to @room
    else
      render 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private
  def room_params
    params.require(:room).permit(:roomnumber, :size, :building)
  end

  def delete
  end

end
