class SessionsController < ApplicationController
  def login
    #Login Form
    if session[:user_id]
      redirect_to(:action => 'home')
    end
  end

  def login_attempt
    authorized_user = Member.authenticate(params[:member][:email], params[:member][:password])
    if session[:user_id]
      redirect_to(:action => 'home')
    end
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:name] = authorized_user.name
      if authorized_user.is_admin
        session[:is_admin] = true
        redirect_to(:action => 'adminhome')
      else
        redirect_to(:action => 'home')
      end
    else
      flash[:notice] = "Invalid Username or Password"
      render "login"
    end
  end

  def home
    if session[:is_admin]
      redirect_to(:action => 'adminhome')
    elsif session[:user_id]
      render "home"
    else
      redirect_to(:action => 'login')
    end

  end

  def logout
    session[:user_id] = nil
    session[:name] = nil
    session[:is_admin] = nil
    flash[:notice] = "You have been successfully logged out"
    redirect_to(:action => 'login')
  end


  def search
    if session[:user_id]
      date_string = params[:session][:date]
      time_local = params[:session][:time]
      size = params[:session][:size]
      building = params[:session][:building]
      @arr1 = date_string.to_s.split('-')
      @arr2 = time_local.to_s.split(':')
      @rooms = {}
      @status = false
      #Datetime type
      @start_date = DateTime.new(@arr1[0].to_i, @arr1[1].to_i, @arr1[2].to_i, @arr2[0].to_i, @arr2[1].to_i)

      # validate date time input
      if (Date.new(@arr1[0].to_i, @arr1[1].to_i, @arr1[2].to_i) < Date.today)
        flash[:notice] = "Please select a valid date"
        redirect_to :action => "home"
      elsif (Date.new(@arr1[0].to_i, @arr1[1].to_i, @arr1[2].to_i) == Date.today)
        if (@arr2[0].to_i < Time.now.hour)
          flash[:notice] = "Please select a valid date"
        elsif (@arr2[0].to_i == Time.now.hour && @arr2[1].to_i < Time.now.min)
          flash[:notice] = "Please select a valid time"
        end
        redirect_to :action => "home"
      elsif ((Date.new(@arr1[0].to_i, @arr1[1].to_i, @arr1[2].to_i) - Date.today) > 7)
        flash[:notice] = "You can only book one week in advance"
        redirect_to :action => "home"
      elsif params[:session][:status] == "true"
        sql = "select * from rooms where "
        if size != ""
          sql += " size = "+size +" and "
        end

        if building != ""
          sql+= " building = '"+building+"' and "
        end
        @end_date = (@start_date.to_time + 2.hours).to_datetime
        @rooms = Room.find_by_sql([sql+"id not in (select roomid from reservations where not (time_end < :st or time_start > :et))", {:st => @start_date, :et => @end_date}])
        render "search"
      else
        @status = true
        sql = "select * from rooms where "
        if size != ""
          sql += " size = "+size +" and "
        end

        if building != ""
          sql+= " building = '"+building+"' and "
        end
        @end_date = (@start_date.to_time + 2.hours).to_datetime
        @rooms = Room.find_by_sql([sql+"id in (select roomid from reservations where not (time_end < :st or time_start > :et))", {:st => @start_date, :et => @end_date}])
        render "search"
      end

      #@reserve = Reservations.where('time_start < ? AND time_start > ?
      #                    OR time_end < ? AND time_end > ?',@start_date + DateTime.now() + @start_date + DateTime.now())

      #@rooms = Member.where('id NOT IN (?)',@reserve)

      #flash[:notice] = @rooms.to_s #"Date = #{params[:session][:time]} time=#{params[:session][:date]}"
      #redirect_to (:action => 'search')

    else
      redirect_to(:action => 'login')
    end
  end

  def book
    flash[:notice] = "we are here with roomno = #{params[:session][:roomnumber]}"
    render "home"
  end

  def session_params
    params.require(:session).permit(:date, :size, :building, :time)
  end

end