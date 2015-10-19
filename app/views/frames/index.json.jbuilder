json.array!(@frames) do |frame|
  json.extract! frame, :id, :game_id, :number, :player_id, :shot_1, :shot_2, :shot_3, :score, :cumulative_score
  json.spare frame.spare?
  json.strike frame.strike?
  json.url frame_url(frame, format: :json)
end
