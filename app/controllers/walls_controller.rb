class WallsController < ApplicationController
  def new
    @wall = Wall.new 
  end

  def create
    @wall = Wall.new(post_params)
    if @wall.save
      redirect_to wall_path(@wall)
    else
      render :new
    end
  end

  def index
    @walls = Wall.page(params[:page]).per(100)
  end

  def show
    @wall = Wall.find(params[:id])
    @messages = Message.all
    render layout: 'wall'
  end

  def edit
    @wall = Wall.find(params[:id])
  end

  def update
    @wall = Wall.find(params[:id])
    if @wall.update_attributes(post_params)
      redirect_to wall_path(@wall)
    else
      render :edit
    end
  end

  private 
  def post_params
    params.require(:wall).permit(:title, :background_image, :qrcode, :logo)
  end
end
