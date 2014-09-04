class Message < ActiveRecord::Base
  def avatar_url
    url = read_attribute(:avatar_url)
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
