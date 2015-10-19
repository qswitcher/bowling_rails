##
# Represents a single frame for a single player in a bowling game. Each player can have
# up to 10 frames per game.
class Frame < ActiveRecord::Base
  belongs_to :game

  validates :shot_1, inclusion: { in: 0..10 }, allow_nil: true
  validates :shot_2, inclusion: { in: 0..10 }, allow_nil: true
  validates :shot_3, inclusion: { in: 0..10 }, allow_nil: true
  validates :player_id, presence: true
  validates :game_id, presence: true
  validates :number, presence: true, inclusion: { in: 1..10 }

  ##
  # Enforces joint uniqueness of (number, player_id, game_id) to prevent duplicate
  # frames per game per player
  validates_uniqueness_of :number, scope: [:player_id, :game_id]

  ##
  # Returns true if this frame is a strike which occurs if all 10 pins are knocked down
  # in the first shot
  def strike?
    shot_1 == 10
  end

  ##
  # Returns true if this frame is a spare, which occurs if the player knocked down all 10 pins
  # in 2 tries
  def spare?
    !shot_1.nil? && !shot_2.nil? && (shot_1 + shot_2 == 10) && (shot_1 != 10)
  end

  ##
  # Returns true if this is the last frame of the game for a player
  def last_frame?
    number == 10
  end

  ##
  # Returns the points earned for this frame using the rules of bowling, which follow the rules
  #
  # * Strikes
  #   A strike is worth 10, plus the value of your next two rolls.
  #
  # * Spares
  #   A spare is worth 10, plus the value of your next roll in the next frame.
  #
  # * Open frame
  #   The score is the total number of pins you knock down in that frame
  #
  # * Scoring the 10th frame
  #   If a spare is thrown on the first two balls in the tenth frame, then the player gets one more shot which is added
  #   to the score. If the player throws a strike, the player gets two more rolls. If the player does not get a spare
  #   in two rolls, then the player does not get an extra roll and the score is determined using the same rules as a
  #   normal open frame.
  def score
    val = 0
    val = val + shot_1 unless shot_1.nil?
    val = val + shot_2 unless shot_2.nil?
    if last_frame?
      val = val + shot_3 if !shot_3.nil? and spare?
    else
      val = val + next_two_rolls if strike?
      val = val + next_roll if spare?
    end
    val
  end

  ##
  # Returns the total score of the game for the player up to and including this frame.
  def cumulative_score
    p_frame = previous_frame
    if p_frame.nil?
      score
    else
      score + p_frame.cumulative_score
    end
  end

  protected

  ##
  # Returns the frame which follows this frame, if it exists
  def next_frame
    Frame.where(game_id: game_id, player_id: player_id, number: number + 1).first
  end

  ##
  # Returns the frame which proceeds this frame, if it exists
  def previous_frame
    Frame.where(game_id: game_id, player_id: player_id, number: number - 1).first
  end

  ##
  # Returns the next roll in the next frame
  def next_roll
    if number < 10 && (n_frame = next_frame)
      if n_frame.shot_1.nil?
        0
      else
        n_frame.shot_1
      end
    else
      0
    end
  end

  ##
  # Returns the next two rolls in the next frames
  def next_two_rolls
    n_frame = next_frame
    val = 0
    unless n_frame.nil?
      val = n_frame.shot_1
      if val == 10
        n_frame2 = n_frame.next_frame
        unless n_frame2.nil?
          val = val + n_frame2.shot_1 unless n_frame.shot_1.nil?
        end
      elsif val > 0
        val = val + n_frame.shot_2 unless n_frame.shot_2.nil?
      end
    end
    val
  end
end
