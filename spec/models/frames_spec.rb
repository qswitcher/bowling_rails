require 'rails_helper'

describe Frame, :type => :model do

  let(:game) { Game.create }
  subject { Frame.create(game: game, player_id: 1, number: 1) }

  it { should respond_to(:shot_1) }
  it { should respond_to(:shot_2) }
  it { should respond_to(:shot_3) }
  it { should respond_to(:player_id) }
  it { should respond_to(:game_id) }
  it { should respond_to(:number) }
  it { should be_valid }

  describe 'joint uniqueness of player_id, game_id, and number' do
    context 'when two frames have the same game and player_id' do
      it 'is not valid to have another frame with the same number' do
        f1 = Frame.create(game: game, player_id: 2, number: 1)
        expect(f1).to be_valid
        f2 = Frame.create(game: game, player_id: 2, number: 1)
        expect(f2).to_not be_valid
      end

      it 'is valid to have another frame with a different number' do
        f1 = Frame.create(game: game, player_id: 2, number: 1)
        expect(f1).to be_valid
        f2 = Frame.create(game: game, player_id: 2, number: 2)
        expect(f2).to be_valid
      end
    end
  end

  describe 'shot validations' do
    it 'is not valid if greater than 10' do
      expect(subject).to be_valid
      subject.shot_1 = 11
      expect(subject).to_not be_valid
    end
  end

  describe 'game_id is nil' do
    before { subject.game_id = nil }
    it { should_not be_valid }
  end

  describe 'player_id is nil' do
    before { subject.player_id = nil }
    it { should_not be_valid }
  end

  describe 'number is nil' do
    before { subject.number = nil }
    it { should_not be_valid }
  end

  describe '#last_frame?' do
    it 'should return false when number is not 10' do
      (1..9).each do |i|
        subject.number = i
        expect(subject.last_frame?).to be_falsey
      end
    end

    it 'should return true if the number is 10' do
      subject.number = 10
      expect(subject.last_frame?).to be_truthy
    end
  end

  describe '#strike?' do
    it 'returns false for an open frame' do
      subject.shot_1 = 1
      subject.shot_2 = 2
      expect(subject.strike?).to be_falsey
    end

    it 'returns false for an incomplete open frame' do
      subject.shot_1 = 1
      subject.shot_2 = nil
      expect(subject.strike?).to be_falsey
    end

    it 'returns false for a spare' do
      subject.shot_1 = 1
      subject.shot_2 = 9
      expect(subject.strike?).to be_falsey
    end

    it 'returns true for a strike' do
      subject.shot_1 = 10
      subject.shot_2 = nil
      expect(subject.strike?).to be_truthy
    end
  end

  describe '#spare?' do
    it 'returns false for an open frame' do
      subject.shot_1 = 1
      subject.shot_2 = 2
      expect(subject.spare?).to be_falsey
    end

    it 'returns false for an incomplete open frame' do
      subject.shot_1 = 1
      subject.shot_2 = nil
      expect(subject.spare?).to be_falsey
    end

    it 'returns true for a spare' do
      subject.shot_1 = 1
      subject.shot_2 = 9
      expect(subject.spare?).to be_truthy
    end

    it 'returns false for a strike' do
      subject.shot_1 = 10
      subject.shot_2 = nil
      expect(subject.spare?).to be_falsey
    end
  end

  describe '#score' do

    describe 'no future frames' do
      it 'should work for nil shot_1 and shot_2' do
        subject.shot_1 = nil
        subject.shot_2 = nil
        expect(subject.score).to eq(0)
      end

      it 'should work for nil shot_2' do
        subject.shot_1 = 4
        subject.shot_2 = nil
        expect(subject.score).to eq(4)
      end

      it 'should work for nil shot_1' do
        subject.shot_1 = nil
        subject.shot_2 = 6
        expect(subject.score).to eq(6)
      end

      it 'should work for non nil shots' do
        subject.shot_1 = 4
        subject.shot_2 = 2
        expect(subject.score).to eq(6)
      end

      it 'should work for a strike' do
        subject.shot_1 = 10
        expect(subject.score).to eq(10)
      end

      it 'should work for a spare' do
        subject.shot_1 = 4
        subject.shot_2 = 6
        expect(subject.score).to eq(10)
      end
    end

    describe 'next frame is incomplete open frame' do
      let!(:frame2) { Frame.create!(game: game, player_id: 1, number: 2, shot_1: 4) }

      it 'doesnt affect open frame' do
        subject.shot_1 = 3
        subject.shot_2 = 4
        expect(subject.score).to eq(7)
      end

      it 'affects a spare' do
        subject.shot_1 = 3
        subject.shot_2 = 7
        expect(subject.score).to eq(14)
      end

      it 'affects a strike' do
        subject.shot_1 = 10
        expect(subject.score).to eq(14)
      end
    end

    describe 'next frame is an open frame' do
      let!(:frame2) { Frame.create!(game: game, player_id: 1, number: 2, shot_1: 4, shot_2: 3) }

      it 'doesnt affect open frame' do
        subject.shot_1 = 3
        subject.shot_2 = 4
        expect(subject.score).to eq(7)
      end

      it 'affects a spare' do
        subject.shot_1 = 3
        subject.shot_2 = 7
        expect(subject.score).to eq(14)
      end

      it 'affects a strike' do
        subject.shot_1 = 10
        expect(subject.score).to eq(17)
      end
    end

    describe 'next frame is a strike' do
      let!(:frame2) { Frame.create!(game: game, player_id: 1, number: 2, shot_1: 10) }

      it 'doesnt affect open frame' do
        subject.shot_1 = 3
        subject.shot_2 = 4
        expect(subject.score).to eq(7)
      end

      it 'affects a spare' do
        subject.shot_1 = 3
        subject.shot_2 = 7
        expect(subject.score).to eq(20)
      end

      it 'affects a strike' do
        subject.shot_1 = 10
        expect(subject.score).to eq(20)
      end

      describe 'frame after next is an open frame' do
        let!(:frame3) { Frame.create!(game: game, player_id: 1, number: 3, shot_1: 2, shot_2: 1) }

        it 'doesnt affect open frame' do
          subject.shot_1 = 3
          subject.shot_2 = 4
          expect(subject.score).to eq(7)
        end

        it 'doesnt affects a spare' do
          subject.shot_1 = 3
          subject.shot_2 = 7
          expect(subject.score).to eq(20)
        end

        it 'affects a strike' do
          subject.shot_1 = 10
          expect(subject.score).to eq(22)
        end
      end

      describe 'frame after next is a strike' do
        let!(:frame3) { Frame.create!(game: game, player_id: 1, number: 3, shot_1: 10) }

        it 'doesnt affect open frame' do
          subject.shot_1 = 3
          subject.shot_2 = 4
          expect(subject.score).to eq(7)
        end

        it 'doesnt affects a spare' do
          subject.shot_1 = 3
          subject.shot_2 = 7
          expect(subject.score).to eq(20)
        end

        it 'affects a strike' do
          subject.shot_1 = 10
          expect(subject.score).to eq(30)
        end
      end
    end



  end

end
