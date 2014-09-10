class Message < ActiveRecord::Base
  mount_uploader :avatar, MessageAvatarUploader

  def original_avatar_url
    url = read_attribute(:original_avatar_url)
    return "" if url.blank?
    unless url.start_with?("http") 
      "https://mp.weixin.qq.com#{url}"
    else 
      url
    end
  end

  def avatar_data_url=(data)
    file = Tempfile.new(['avatar', '.png'])
    file.binmode
    file.write Base64.decode64(data)
    
    self.avatar = file
    file.close
  end

  def display_avatar_url
    if avatar_url.present?
      avatar_url
    else
      original_avatar_url
    end
  end
end
