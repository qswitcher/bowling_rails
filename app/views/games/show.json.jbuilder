json.extract! @game, :id, :name, :created_at, :updated_at

json.players do
  json.array! @game.frames_by_player_id.each do |player_id, frames|
    json.player_id player_id
    json.score @game.score_for_player(player_id)
    json.frames do
      json.array!(frames) do |frame|
        json.extract! frame, :shot_1, :shot_2, :shot_3, :score, :number, :cumulative_score
        json.url frame_url(frame, format: :json)
      end
    end
  end
end