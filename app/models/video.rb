class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :video, :styles => {
    :medium => { :geometry => "640x480", :format => 'flv' },
    :large => { :geometry => "2560x2100#", :format => 'jpg', :time => 10 },
    :thumb => { :geometry => "300x300#", :format => 'jpg', :time => 10 }
  }, :processors => [:ffmpeg]
  validates :video,:video_title,:presence => true
end
