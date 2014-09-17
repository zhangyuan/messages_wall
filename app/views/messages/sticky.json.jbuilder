json.messages @messages do |message|
  next unless message.published?
  json.(message, :id, :content, :display_avatar_url, :remark_name)
end
