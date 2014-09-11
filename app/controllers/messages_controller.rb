class MessagesController < ApplicationController
  before_filter :authenticate, except: [:wall, :recent]

  skip_before_action :verify_authenticity_token
  cors_set_access_control_headers only: [:batch, :create, :destroy]

  def recent
    @messages = Message.order("id desc").page(params[:page]).per(100)
  end

  def wall
    render layout: 'wall'
  end

  def batch
    messages = Message.where(message_id: params[:ids])
    render json: {messages: messages}
  end

  def create
    message = Message.new(post_params)
    if message.save
      render json: {status: 0 }
    else
      render json: {status: 1}
    end
  end

  def destroy
    response.headers['Access-Control-Allow-Origin'] = '*'
    message = Message.find_by_message_id(params[:id])
    
    if message.present?
      if message.destroy
        render json: {status: 0} 
      else
        render json: {status: 1}
      end
    else
      render json: {status: 2}
    end
  end

  def index
    @messages = Message.page(params[:page]).per(30)
  end

  private
  def post_params
    params.require(:message).permit(:message_id, :content, :remark_name, :original_avatar_url, :avatar_data_url)
  end

  def authenticate
    token = session[:token] || params[:token]
    unless wall = Wall.find_by(token: token)
      render json: {status: 9}
    end
  end
end
