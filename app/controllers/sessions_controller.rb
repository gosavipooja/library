class SessionsController < ApplicationController
  def login
    #Login Form
    if session[:user_id]
      redirect_to(:action => 'home')
    end
  end
  def login_attempt
    authorized_user = Member.authenticate(params[:member][:email],params[:member][:password])
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

  def logout
    session[:user_id] = nil
    session[:name] = nil
    session[:is_admin] = nil
    flash[:notice] = "You have been successfully logged out"
    redirect_to(:action => 'login')
  end
end