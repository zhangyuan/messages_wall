class Wall < ActiveRecord::Base
  validates :title, presence: true

  mount_uploader :background_image, WallUploaderUploader
  mount_uploader :qrcode, WallUploaderUploader
  mount_uploader :logo, WallUploaderUploader
end
