json.extract! @user_cover, :id, :created_at, :updated_at
json.user_image_url @user_cover.image.url
