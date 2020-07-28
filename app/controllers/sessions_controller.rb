class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # success logic, log them in
      session[:user_id] = user.id
      redirect_to '/'
    else
        # failure, render login form
        redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    # session.delete(:user_id)
    redirect_to '/login'
  end
end
