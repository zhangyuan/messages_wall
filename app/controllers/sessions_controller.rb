class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

	def index
		session[:token] = params[:token]
		render json: {status: 0, token: session[:token]}
	end

  def create
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: {status: 0, token: params[:token]}
  end
end
