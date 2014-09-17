json.messages @messages do |message|
  json.(message, :id, :content, :display_avatar_url, :remark_name)
end
