require 'digest/sha1'

class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
      @members = Member.all
  end

  def updateuser
    @member = Member.authenticate(params[:member][:email], params[:member][:old_password_field])

    if (@member.id != session[:user_id])
      flash[:notice]="Invalid email id entered"
      redirect_to :controller => 'sessions', :action => 'settings'
      return
    end

    if (@member)
      if @member.update(member_param)
        flash[:notice]="Profile details updated"
        redirect_to :controller => 'sessions', :action => 'home'
      else
        flash[:notice]="Please enter valid email id and password"
        redirect_to :controller => 'sessions', :action => 'settings'
      end
    else
      flash[:notice]="Please enter valid email id and password"
      redirect_to :controller => 'sessions', :action => 'settings'
    end
  end

  def create
    @member = Member.new(member_param)
    if !session[:is_admin] && @member.is_admin
      redirect_to :action => :index
    else
      if @member.save
        if @member.is_admin
          redirect_to :controller => 'sessions', :action => 'adminhome'
        else
          redirect_to :controller => 'sessions', :action => 'login'
        end
      else
        flash[:notice]="Please enter valid email id or password"
        redirect_to :action => :index
      end
    end
  end

  def destroy
    if session[:is_admin]
      @member = Member.find(params[:id])
      is_admin = @member.is_admin
      @member.destroy

      if is_admin
        redirect_to :action => :show_admin
      else
        redirect_to :action => :show_member
      end
    end
  end

  def show
    if session[:is_admin] || (params[:id].to_s == session[:user_id].to_s)
      @member = Member.find(params[:id])
      @notifications = Notification.find_by_sql(["select * from notifications where userid = :uid order by time_start desc", {:uid => params[:id]}])
      @reservations = Reservation.find_by_sql(["select * from reservations where userid = :uid order by time_start desc", {:uid => params[:id]}])
    else
      redirect_to :action => :home, :controller => 'sessions'
    end
  end
  def new
    @member = Member.new
  end

  def create_admin
    @member = Member.new
  end

  def show_admin
    if session[:user_id]
      @members = Member.where("is_admin = true")
    else
      redirect_to :action => "login", :controller => "sessions"
    end
  end

  def show_member
    if session[:user_id]
      @members = Member.where("is_admin != true")
    else
      redirect_to :action => "login", :controller => "sessions"
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_param
    params.require(:member).permit(:email, :name, :password_field, :is_admin)
  end
end
