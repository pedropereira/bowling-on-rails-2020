# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::Game do
  describe '#roll' do
    it 'produces a perfect game (only strikes) with two bonus rolls in the final frame' do
      model = create_game
      entity = described_class.new(model)

      results = 12.times.map { entity.roll(10) }
      model.reload

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it 'produces a game with a bonus roll after a spare in the final frame' do
      model = create_game
      entity = described_class.new(model)

      results = 21.times.map { entity.roll(5) }
      model.reload

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it 'produces a game with no strikes nor spares' do
      model = create_game
      entity = described_class.new(model)

      results = 20.times.map { entity.roll(3) }
      model.reload

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it "produces uncle bob's game" do
      model = create_game
      entity = described_class.new(model)

      results = [
        entity.roll(1),
        entity.roll(4),
        entity.roll(4),
        entity.roll(5),
        entity.roll(6),
        entity.roll(4),
        entity.roll(5),
        entity.roll(5),
        entity.roll(10),
        entity.roll(0),
        entity.roll(1),
        entity.roll(7),
        entity.roll(3),
        entity.roll(6),
        entity.roll(4),
        entity.roll(10),
        entity.roll(2),
        entity.roll(8),
        entity.roll(6)
      ]
      model.reload

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end
  end

  def create_game
    game_model = FactoryBot.create(:game)
    FactoryBot.create(:frame, game_id: game_model.id)

    game_model
  end
end
