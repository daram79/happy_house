json.array!(@user_covers) do |user_cover|
  json.extract! user_cover, :id
  json.url user_cover_url(user_cover, format: :json)
end
