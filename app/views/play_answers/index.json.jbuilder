json.array!(@play_answers) do |play_answer|
  json.extract! play_answer, :id
  json.url play_answer_url(play_answer, format: :json)
end
