json.conversations @conversations.each do |c|
  json.conversation_id c.id
  json.subject c.subject
  json.created_at c.created_at
  json.updated_at c.updated_at
  json.messages c.messages
end
