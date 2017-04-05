module ConversationsHelper
  def page_header(text)
    content_for(:page_header) { text.to_s }
  end

  def avatar_for(user)
    image_tag user.image_url, alt: user.first_name
  end
end
