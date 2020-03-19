# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FrameRepository do
  describe '#all' do
    it 'returns all frames' do
      frame1 = FactoryBot.create(:frame)
      frame2 = FactoryBot.create(:frame)

      result = described_class.new.all

      expect(result).to eq([frame1, frame2])
    end
  end

  describe '#build' do
    it 'builds a new frame' do
      game = FactoryBot.create(:game)

      result = described_class.new.build(game_id: game.id)

      expect(Frame.count).to eq(0)
      expect(result.created_at).to eq(nil)
      expect(result.game_id).to eq(game.id)
      expect(result.rolls).to eq([])
      expect(result.updated_at).to eq(nil)
    end
  end

  describe '#create' do
    it 'creates a new frame' do
      game = FactoryBot.create(:game)

      result = described_class.new.create(game_id: game.id)

      expect(Frame.count).to eq(1)
      expect(result.created_at).to_not eq(nil)
      expect(result.game_id).to eq(game.id)
      expect(result.rolls).to eq([])
      expect(result.updated_at).to_not eq(nil)
    end
  end
end
