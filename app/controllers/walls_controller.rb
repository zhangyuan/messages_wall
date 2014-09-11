class WallsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:retrieve]
  cors_set_access_control_headers only: [:retrieve]

  require_signed_in only: [:new, :create, :index, :edit, :update]

  def new
    @wall = Wall.new 
  end

  def create
    @wall = current_account.walls.new(post_params)
    if @wall.save
      redirect_to wall_path(@wall)
    else
      render :new
    end
  end

  def index
    @walls = current_account.walls.page(params[:page]).per(100)
  end

  def retrieve
    unless @wall = Wall.find_by(token: params[:token])
      render json: {status: 1, msg: "Not Found"}
    end
  end

  def show
    @wall = Wall.find(params[:id])
    set_page_title @wall.title
    if @wall.duration > 0
      @messages = @wall.messages.where("created_at > ?", @wall.duration.minutes.ago)
    else
      @messages = @wall.messages.limit(50)
    end
    render layout: 'wall'
  end

  def edit
    @wall = current_account.walls.find(params[:id])
  end

  def update
    @wall = current_account.walls.find(params[:id])
    if @wall.update_attributes(post_params)
      redirect_to wall_path(@wall)
    else
      render :edit
    end
  end

  private 
  def post_params
    params.require(:wall).permit(:title, :background_image, :qrcode, :logo, :duration)
  end
end
