class HomeController < ApplicationController
  
  def index
    if current_user
      @videos = current_user.videos.order("created_at DESC")
      render "after_login"
    end
  end
end
