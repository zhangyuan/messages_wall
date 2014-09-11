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
end
