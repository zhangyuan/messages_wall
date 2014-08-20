class Message < ActiveRecord::Base
  def avatar_url
    url = read_attribute(:avatar_url)
    unless url.start_with?("http") 
      "https://mp.weixin.qq.com#{url}"
    else 
      url
    end
  end
end
