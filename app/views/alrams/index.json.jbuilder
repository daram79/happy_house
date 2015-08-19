json.array!(@alrams) do |alram|
  json.extract! alram, :id, :alram_type, :created_at
  json.time_word @time_word[alram.id]
  json.send_user alram.send_user
  
  if(alram.send_user.user_cover && alram.send_user.user_cover.image.url)
  	json.send_user_image_url alram.send_user.user_cover.image.url
  else
  	json.send_user_image_url "/uploads/cover/cover.png"
  end
  
  if(alram.send_user.user_cover && alram.send_user.user_cover.name)
  	json.send_user_name alram.send_user.user_cover.name
  else
  	json.send_user_name ""
  end
  
  if alram.alram_type == "Feed"
    json.feed_photo alram.alram.feed_photos.first
  elsif alram.alram_type == "VisitorBook" || alram.alram_type == "User"
  	json.feed_photo nil
  else
    json.feed_photo alram.alram.feed.feed_photos.first
  end
  
  json.url alram_url(alram, format: :json)
end