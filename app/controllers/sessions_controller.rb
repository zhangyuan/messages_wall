class SessionsController < ApplicationController
	def index
		session[:token] = params[:token]
		render json: {status: 0, token: session[:token]}
	end
end
