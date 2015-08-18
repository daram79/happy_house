json.array!(@visitor_books) do |visitor_book|
  json.extract! visitor_book, :id, :user_id, :send_user_id, :content, :comment
  if(visitor_book.send_user.user_cover && visitor_book.send_user.user_cover.image.url)
  	json.send_user_image_url visitor_book.send_user.user_cover.image.url
  else
    json.send_user_image_url "/uploads/cover/cover.png"
  end
  json.time_word @time_word[visitor_book.id]
  json.send_user_name visitor_book.send_user.user_cover.name
end
