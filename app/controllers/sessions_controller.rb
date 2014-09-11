class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  cors_set_access_control_headers

  def new
  end

  def create
    account = Account.find_by(email: params[:email])
    if account && account.authenticate(params[:password])
      session[:account_id] = account.id
      redirect_to walls_path
    else  
      render :new
    end 
  end 
end
