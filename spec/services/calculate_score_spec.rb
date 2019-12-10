# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CalculateScore do
  describe '#call' do
    it 'calculates the total score for a perfect game (only strikes)' do
      result = described_class.new.call(perfect_game.frames)

      expect(result).to eq(300)
    end

    it 'calculates the total score for a game full of spares and a bonus roll' do
      result = described_class.new.call(spares_with_bonus_roll_game.frames)

      expect(result).to eq(150)
    end

    it "calculates the total score for uncle bob's game" do
      result = described_class.new.call(uncle_bob_game.frames)

      expect(result).to eq(133)
    end
  end

  def perfect_game
    game = FactoryBot.create(:game)
    frames = 10.times.map do
      FactoryBot.create(:frame, game_id: game.id, state: 'strike')
    end
    FactoryBot.create(:roll, frame_id: frames[0].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[1].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[2].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[3].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[4].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[5].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[6].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[7].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[8].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 10)

    game
  end

  def spares_with_bonus_roll_game
    game = FactoryBot.create(:game)
    frames = 10.times.map do
      FactoryBot.create(:frame, game_id: game.id, state: 'spare')
    end
    FactoryBot.create(:roll, frame_id: frames[0].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[0].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[1].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[1].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[2].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[2].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[3].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[3].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[4].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[4].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[5].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[5].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[6].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[6].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[7].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[7].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[8].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[8].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 5)

    game
  end

  def uncle_bob_game
    game = FactoryBot.create(:game)
    frames = [
      FactoryBot.create(:frame, game_id: game.id, state: 'open'),
      FactoryBot.create(:frame, game_id: game.id, state: 'open'),
      FactoryBot.create(:frame, game_id: game.id, state: 'spare'),
      FactoryBot.create(:frame, game_id: game.id, state: 'spare'),
      FactoryBot.create(:frame, game_id: game.id, state: 'strike'),
      FactoryBot.create(:frame, game_id: game.id, state: 'open'),
      FactoryBot.create(:frame, game_id: game.id, state: 'spare'),
      FactoryBot.create(:frame, game_id: game.id, state: 'spare'),
      FactoryBot.create(:frame, game_id: game.id, state: 'strike'),
      FactoryBot.create(:frame, game_id: game.id, state: 'spare')
    ]
    FactoryBot.create(:roll, frame_id: frames[0].id, pins: 1)
    FactoryBot.create(:roll, frame_id: frames[0].id, pins: 4)
    FactoryBot.create(:roll, frame_id: frames[1].id, pins: 4)
    FactoryBot.create(:roll, frame_id: frames[1].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[2].id, pins: 6)
    FactoryBot.create(:roll, frame_id: frames[2].id, pins: 4)
    FactoryBot.create(:roll, frame_id: frames[3].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[3].id, pins: 5)
    FactoryBot.create(:roll, frame_id: frames[4].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[5].id, pins: 0)
    FactoryBot.create(:roll, frame_id: frames[5].id, pins: 1)
    FactoryBot.create(:roll, frame_id: frames[6].id, pins: 7)
    FactoryBot.create(:roll, frame_id: frames[6].id, pins: 3)
    FactoryBot.create(:roll, frame_id: frames[7].id, pins: 6)
    FactoryBot.create(:roll, frame_id: frames[7].id, pins: 4)
    FactoryBot.create(:roll, frame_id: frames[8].id, pins: 10)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 2)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 8)
    FactoryBot.create(:roll, frame_id: frames[9].id, pins: 6)

    game
  end
end
