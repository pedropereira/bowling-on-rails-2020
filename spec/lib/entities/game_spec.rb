# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::Game do
  describe '#roll' do
    it 'produces a perfect game (only strikes) with two bonus rolls in the final frame' do
      attributes = create_game
      entity = described_class.new(attributes)

      results = 12.times.map { entity.roll(10) }
      entity = game_repository.find(entity.id)

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it 'produces a game with a bonus roll after a spare in the final frame' do
      attributes = create_game
      entity = described_class.new(attributes)

      results = 21.times.map { entity.roll(5) }
      entity = game_repository.find(entity.id)

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it 'produces a game with no strikes nor spares' do
      attributes = create_game
      entity = described_class.new(attributes)

      results = 20.times.map { entity.roll(3) }
      entity = game_repository.find(entity.id)

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end

    it "produces uncle bob's game" do
      attributes = create_game
      entity = described_class.new(attributes)

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
      entity = game_repository.find(entity.id)

      expect(entity.state).to eq('finished')
      expect(results.uniq).to eq([true])
    end
  end

  def create_game
    model = FactoryBot.create(:game, frames: [FactoryBot.create(:frame)])

    Serializers::Db::Game.new.from(model)
  end

  def game_repository
    @game_repository ||= Repositories::Game.new
  end
end
