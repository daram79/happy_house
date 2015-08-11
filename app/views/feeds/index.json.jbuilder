json.array!(@feeds) do |feed|
  json.extract! feed, :id, :user_id, :content, :html_content, :like_count, :comment_count, :created_at
  if(feed.user.user_cover)
  	json.user_name feed.user.user_cover.name
  else
    json.user_name feed.user.id
  end
  
  if(feed.user.user_cover && feed.user.user_cover.image.url)
  	json.user_image_url feed.user.user_cover.image.url
  else
    json.user_image_url "/uploads/cover/cover.png"
  end
  
  json.time_word @time_word[feed.id]
  json.user feed.user
  json.feed_photo feed.feed_photos[0]
  json.like_count feed.likes.count
  json.comment_count feed.comments.count
  json.current_user_id @current_user.id
  if feed.likes.find_by_user_id(@current_user.id)
    json.is_like true
  else
    json.is_like false
  end
end