require 'digest/sha1'

class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.all
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

  def new
    @member = Member.new
  end

  def create_admin
    @member = Member.new
  end

  def show_admin
    @members = Member.where("is_admin = true")
  end
  def show_member
    @members = Member.where("is_admin != true")
  end
  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_param
    params.require(:member).permit(:email, :name, :password_field, :is_admin)
  end
end
