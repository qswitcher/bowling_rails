##
# Represents a single bowling game.
class Game < ActiveRecord::Base
  has_many :frames, dependent: :destroy

  ##
  # Returns the frames for this game, grouped by player_id
  def frames_by_player_id
    frames.group_by { |f| f.player_id }
  end

  ##
  # Returns the total score for a player for this game if it exists, nil otherwise.
  def score_for_player(player_id)
    highest_frame = Frame.where(game: self, player_id: player_id).order('number DESC').first
    highest_frame.cumulative_score unless highest_frame.nil?
  end
end
