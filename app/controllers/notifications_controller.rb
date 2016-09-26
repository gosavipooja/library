class NotificationsController < ApplicationController
  def create
    emails = params[:notification][:email]
    text = params[:notification][:text]
    date = DateTime.now

    emaillist = {}
    emaillist = emails.to_s.split(",")

    emaillist.each do |email|
      @notification = Notification.new
      user = Member.find_by_email(email)

      if user
        @notification.userid= user.id
        @notification.text=text
        @notification.time_start=  date
        @notification.save
      end

    end
    redirect_to :controller => 'sessions', :action => 'home'

  end

  def destroy
    @notification = Notification.find(params[:id])
    userid = @notification.userid
    if @notification.destroy
      redirect_to :controller => 'members', :action => 'show', :id => userid
    end
  end

  end