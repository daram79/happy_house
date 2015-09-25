json.array!(@compatibilities) do |compatibility|
  json.extract! compatibility, :id
  json.url compatibility_url(compatibility, format: :json)
end
