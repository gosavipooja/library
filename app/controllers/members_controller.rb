require 'digest/sha1'

class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  def index
    @members = Member.all
  end

  def create
    @member = Member.new(member_param)
    if @member.save
      redirect_to :controller => 'sessions', :action => 'login'
    else
      redirect_to :action => :index
    end
  end

  def new
    @member = Member.new
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_param
    params.require(:member).permit(:email, :name, :password_field)
  end
end
