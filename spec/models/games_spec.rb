require 'rails_helper'

describe Game, :type => :model do

  subject { Game.create }

  it { should respond_to(:frames) }
  it { should be_valid }

  describe '#frames_by_player_id' do
    before do
      (1..2).each do |player_id|
        (1..2).each do |number|
          Frame.create(game: subject, player_id: player_id, number: number, shot_1: 2, shot_2: 3)
        end
      end
    end

    it 'should return the frames grouped by player' do
      players = subject.frames_by_player_id
      expect(players.length).to eq(2)
      expect(players[1]).to_not be_nil
      expect(players[1].length).to eq(2)
      expect(players[2]).to_not be_nil
      expect(players[2].length).to eq(2)
    end
  end

  describe '#score_for_player' do
    it 'should return the cumulative score for a player in the game' do
      (1..2).each { |number| Frame.create(game: subject, player_id: 1, number: number, shot_1: 10) }
      expect(subject.score_for_player(1)).to eq(30)
    end

    it 'should return nil if the player is not in the game' do
      expect(subject.score_for_player(99)).to be_nil
    end
  end

end
