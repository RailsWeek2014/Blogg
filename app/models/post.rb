class Post < ActiveRecord::Base
mount_uploader :picture, PictureUploader
validates :title, presence: true
validates :content, presence: true


belongs_to :user

 
end
