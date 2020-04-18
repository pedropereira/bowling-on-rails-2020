# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Game do
  describe '#create' do
    it 'creates a new game' do
      repository = described_class.new

      result = repository.create

      expect(Game.count).to eq(1)
      expect(result.created_at).to_not eq(nil)
      expect(result.id).to_not eq(nil)
      expect(result.state).to eq('ongoing')
      expect(result.updated_at).to_not eq(nil)
    end
  end

  describe '#find' do
    it 'returns existing game' do
      game = create_game
      repository = described_class.new

      result = repository.find(game.id)

      expect(result).to eq(game)
    end

    it 'raises ActiveRecord::RecordNotFound exception when game does not exist' do
      repository = described_class.new

      execution = -> { repository.find('does_not_exist') }

      expect(execution).to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#update' do
    it 'updates an existing game' do
      game = create_game(state: Entities::Game::ONGOING)
      repository = described_class.new

      result = repository.update(game.id, state: Entities::Game::FINISHED)

      expect(result.state).to eq('finished')
    end
  end

  def create_game(params = {})
    model = FactoryBot.create(:game, params)
    attributes = Serializers::Db::Game.new.from(model)

    Entities::Game.new(attributes)
  end
end
