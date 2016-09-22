class SessionsController < ApplicationController
  def login
    #Login Form
  end
  def login_attempt    authorized_user = Member.authenticate(params[:member][:email],params[:member][:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:name] = authorized_user.name
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      render "login"
    end
  end
end