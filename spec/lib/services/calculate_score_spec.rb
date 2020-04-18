# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CalculateScore do
  describe '#for_game' do
    it 'calculates the total score for a perfect game (only strikes)' do
      calculate_score = described_class.new

      result = calculate_score.for_game(perfect_game)

      expect(result).to eq(300)
    end

    it 'calculates the total score for a game full of spares and a bonus roll' do
      calculate_score = described_class.new

      result = calculate_score.for_game(spares_with_bonus_roll_game)

      expect(result).to eq(150)
    end

    it "calculates the total score for uncle bob's game" do
      calculate_score = described_class.new

      result = calculate_score.for_game(uncle_bob_game)

      expect(result).to eq(133)
    end
  end

  def perfect_game
    game = FactoryBot.create(:game)
    frames = 10.times.map do
      FactoryBot.create(:frame, game_id: game.id)
    end
    frame_scores = [
      [10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10, 10]
    ]

    frame_scores.each_with_index do |frame, index|
      frame.each do |pins|
        FactoryBot.create(:roll, frame_id: frames[index].id, pins: pins)
      end
    end

    attributes = Serializers::Db::Game.new.from(game)
    Entities::Game.new(attributes)
  end

  def spares_with_bonus_roll_game
    game = FactoryBot.create(:game)
    frames = 10.times.map do
      FactoryBot.create(:frame, game_id: game.id)
    end
    frame_scores = [
      [5, 5], [5, 5], [5, 5], [5, 5], [5, 5], [5, 5], [5, 5], [5, 5], [5, 5], [5, 5, 5]
    ]

    frame_scores.each_with_index do |frame, index|
      frame.each do |pins|
        FactoryBot.create(:roll, frame_id: frames[index].id, pins: pins)
      end
    end

    attributes = Serializers::Db::Game.new.from(game)
    Entities::Game.new(attributes)
  end

  def uncle_bob_game
    game = FactoryBot.create(:game)
    frames = 10.times.map do
      FactoryBot.create(:frame, game_id: game.id)
    end
    frame_scores = [
      [1, 4], [4, 5], [6, 4], [5, 5], [10], [0, 1], [7, 3], [6, 4], [10], [2, 8, 6]
    ]

    frame_scores.each_with_index do |frame, index|
      frame.each do |pins|
        FactoryBot.create(:roll, frame_id: frames[index].id, pins: pins)
      end
    end

    attributes = Serializers::Db::Game.new.from(game)
    Entities::Game.new(attributes)
  end
end
