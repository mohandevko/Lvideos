class VideosController < ApplicationController
  before_filter :is_login?
  def index
    
  end
  
  def new
    @video = Video.new
  end
  
  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.save
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
  def show
    @video = Video.find(params[:id])
  end
  
  private
  def video_params
    params.require(:video).permit!
  end
end
