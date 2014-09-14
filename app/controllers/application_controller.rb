class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def self.cors_set_access_control_headers(options = {})
    after_filter(options) do
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Origin'] = '*'
    end
  end

  def current_account
    if defined?(@current_account) 
      @current_account
    else
      @current_account = Account.find_by(id: session[:account_id])
    end 
  end

  def self.require_signed_in(options = {})
    before_filter(options) do
      redirect_to new_session_path unless current_account
    end
  end

  def set_page_title(title)
    @page_title = title
  end

  def signed_in?
    !! current_account 
  end
end
