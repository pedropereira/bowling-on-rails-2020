# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FrameRepository do
  describe '#all' do
    it 'returns all frames' do
      frame1 = FactoryBot.create(:frame)
      frame2 = FactoryBot.create(:frame)

      result = described_class.new.all

      expect(result).to eq([frame1, frame2])
    end

    it 'returns filtered frames' do
      FactoryBot.create(:frame)
      frame = FactoryBot.create(:frame, state: 'strike')

      result = described_class.new.all(state: 'strike')

      expect(result).to eq([frame])
    end
  end

  describe '#build' do
    it 'builds a new frame' do
      game = FactoryBot.create(:game)

      result = described_class.new.build(game_id: game.id)

      expect(Frame.count).to eq(0)
      expect(result.created_at).to eq(nil)
      expect(result.game_id).to eq(game.id)
      expect(result.state).to eq('open')
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
      expect(result.state).to eq('open')
      expect(result.rolls).to eq([])
      expect(result.updated_at).to_not eq(nil)
    end
  end

  describe '#update' do
    it 'updates an existing frame' do
      frame = FactoryBot.create(:frame, state: 'open')

      described_class.new.update(frame, state: 'strike')

      expect(frame.state).to eq('strike')
    end
  end
end
