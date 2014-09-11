class Wall < ActiveRecord::Base
  validates :title, presence: true

  mount_uploader :background_image, WallUploaderUploader
  mount_uploader :qrcode, WallUploaderUploader
  mount_uploader :logo, WallUploaderUploader

  before_create :generate_token

  def generate_token
    loop do 
      value = SecureRandom.hex(20)
      unless self.class.where(token: value).exists?
        self.token = value
        break
      end
    end
  end
end
