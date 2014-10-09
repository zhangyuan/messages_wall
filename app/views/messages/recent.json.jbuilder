json.messages @messages do |message|
  json.(message, :id, :display_avatar_url, :remark_name)
  json.content message.content.to_s.strip
end
