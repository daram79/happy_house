json.array!(@comments) do |comment|
  json.extract! comment, :id, :content
  json.time_word @time_word[comment.id] 
  json.user_id comment.user.id
  
  if(comment.user.user_cover && comment.user.user_cover.image.url)
  	json.user_image_url comment.user.user_cover.image.url
  else
  	json.user_image_url "/uploads/cover/cover.png"
  end
  
  if(comment.user.user_cover)
  	json.user_name comment.user.user_cover.name
  else
    json.user_name comment.user.id
  end
end