class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  cors_set_access_control_headers
end
