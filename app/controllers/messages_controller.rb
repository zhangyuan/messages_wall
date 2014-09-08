class MessagesController < ApplicationController
  before_filter :authenticate, except: [:wall, :recent]

  protect_from_forgery only: [:null_session]

  def recent
    messages = Message.order("id desc").page(params[:page]).per(100)
    render json: {messages: messages}
  end

  def wall
    render layout: 'wall'
  end

  def batch
    messages = Message.where(message_id: params[:ids])
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: {messages: messages}
  end

  def create
    response.headers['Access-Control-Allow-Origin'] = '*'
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
    if token != Rails.application.secrets.auth_token
      render json: {status: 9}
    end
  end
end
