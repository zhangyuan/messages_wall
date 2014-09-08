class Message < ActiveRecord::Base
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
    file = Tempfile.new('avatar.png')
    file.binmode
    file = File.new("/tmp/a.png", "wb")
    logger.debug(file.path)
    file.write Base64.decode64(data)
    file.close
  end
end
