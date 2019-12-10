# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameRepository do
  describe '#create' do
    it 'creates a new game' do
      result = described_class.new.create

      expect(Game.count).to eq(1)
      expect(result.created_at).to_not eq(nil)
      expect(result.state).to eq('ongoing')
      expect(result.frames).to eq([])
      expect(result.updated_at).to_not eq(nil)
    end
  end

  describe '#update' do
    it 'updates an existing game' do
      game = FactoryBot.create(:game, state: 'ongoing')

      described_class.new.update(game, state: 'finished')

      expect(game.state).to eq('finished')
    end
  end
end
