json.wall do
  json.(@wall, :title, :background_image_url, :qrcode_url, :logo_url)
  json.messages @messages do  |message|
    json.(message, :display_avatar_url, :remark_name, :content)
  end

  json.sticky_messages @sticky_messages do |message|
    json.(message, :display_avatar_url, :remark_name, :content)
  end
end
