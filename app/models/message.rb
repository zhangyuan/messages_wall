class Message < ActiveRecord::Base
  mount_uploader :avatar, MessageAvatarUploader

  STATUS = %w(published deleted)
  TYPE = %w(normal sticky)

  scope :published, -> { where(publishing_status_id: STATUS.index('published')) }
  scope :sticky, -> { where(message_type_id: TYPE.index('sticky'))}
  scope :normal, -> { where(message_type_id: TYPE.index('normal'))}

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

  def publishing_status=(status)
    self.publishing_status_id = STATUS.index(status.to_s) 
  end

  def publishing_status
    if publishing_status_id && publishing_status_id >= 0
      STATUS.at publishing_status_id
    end
  end

  def message_type=(type)
    self.message_type_id = TYPE.index(type) 
  end

  def message_type
    if message_type_id && message_type_id >= 0 
      TYPE.at message_type_id
    end
  end

  def soft_delete
    self.publishing_status = "deleted" 
    save
  end
end
