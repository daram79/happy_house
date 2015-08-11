json.extract! @feed, :id, :user_id, :content, :html_content, :created_at, :updated_at
json.user @feed.user
json.feed_photo @feed.feed_photos[0]
json.comment_count @feed.comment_count
json.like_count @feed.like_count
json.time_word @time_word

if(@feed.user.user_cover && @feed.user.user_cover.image.url)
  json.user_image_url @feed.user.user_cover.image.url
else
  json.user_image_url "/uploads/cover/cover.png"
end

if(@feed.user.user_cover)
  	json.user_name @feed.user.user_cover.name
  else
    json.user_name @feed.user.id
  end
if @current_user && @feed.likes.find_by_user_id(@current_user.id)
  json.is_like true
else
  json.is_like false
end