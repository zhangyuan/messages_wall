class MessagesController < ApplicationController
  before_filter :authenticate, except: [:wall, :recent]

  skip_before_action :verify_authenticity_token
  cors_set_access_control_headers only: [:batch, :create, :destroy, :sticky]

  def batch
    messages = current_wall.messages.published.where(message_id: params[:ids])
    render json: {messages: messages}
  end

  def sticky
    @messages = current_wall.messages.sticky.order("id desc").limit(1)
  end

  def create
    message = current_wall.messages.new(post_params)
    if message.save
      render json: {status: 0 }
    else
      render json: {status: 1}
    end
  end

  def destroy
    message = current_wall.messages.published.where(message_id: params[:id]).last

    if message
      if message.soft_delete
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
    params.require(:message).permit(:message_id, :content, :remark_name, :original_avatar_url, :avatar_data_url, :message_type)
  end

  def authenticate
    unless current_wall
      render json: {status: 10}
    end
  end

  def current_wall
    if defined?(@current_wall)
      @current_wall
    else
      @current_wall = Wall.find_by(token: params[:token])
    end
  end
end
