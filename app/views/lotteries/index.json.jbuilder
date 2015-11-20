json.array!(@lotteries) do |lottery|
  json.extract! lottery, :id
  json.url lottery_url(lottery, format: :json)
end
