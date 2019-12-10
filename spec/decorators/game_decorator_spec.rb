# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GameDecorator do
  describe '#roll' do
    it 'produces a perfect game (only strikes) with two bonus rolls in the final frame' do
      game = create_game
      decorator = described_class.new(game)

      results = 12.times.map { decorator.roll(10) }
      game.reload

      expect(game.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it 'produces a game with a bonus roll after a spare in the final frame' do
      game = create_game
      decorator = described_class.new(game)

      results = 21.times.map { decorator.roll(5) }
      game.reload

      expect(game.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it 'produces a game with no strikes nor spares' do
      game = create_game
      decorator = described_class.new(game)

      results = 20.times.map { decorator.roll(3) }
      game.reload

      expect(game.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it "produces uncle bob's game" do
      game = create_game
      decorator = described_class.new(game)

      results = [
        decorator.roll(1),
        decorator.roll(4),
        decorator.roll(4),
        decorator.roll(5),
        decorator.roll(6),
        decorator.roll(4),
        decorator.roll(5),
        decorator.roll(5),
        decorator.roll(10),
        decorator.roll(0),
        decorator.roll(1),
        decorator.roll(7),
        decorator.roll(3),
        decorator.roll(6),
        decorator.roll(4),
        decorator.roll(10),
        decorator.roll(2),
        decorator.roll(8),
        decorator.roll(6)
      ]
      game.reload

      expect(game.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end
  end

  def create_game
    game = FactoryBot.create(:game)
    FactoryBot.create(:frame, game_id: game.id)

    game
  end
end
