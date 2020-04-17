# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Frame do
  describe '#all' do
    it 'returns all frames' do
      frame1 = create_frame
      frame2 = create_frame
      repository = described_class.new

      result = repository.all

      expect(result).to eq([frame1, frame2])
    end
  end

  describe '#build' do
    it 'builds a new frame' do
      game = create_game
      repository = described_class.new

      result = repository.build(game_id: game.id, kind: Entities::Frame::TENTH)

      expect(Frame.count).to eq(0)
      expect(result.created_at).to eq(nil)
      expect(result.game_id).to eq(game.id)
      expect(result.id).to eq(nil)
      expect(result.kind).to eq('tenth')
      expect(result.rolls).to eq([])
      expect(result.updated_at).to eq(nil)
    end
  end

  describe '#create' do
    it 'creates a new frame' do
      game = create_game
      repository = described_class.new

      result = repository.create(game_id: game.id, kind: Entities::Frame::REGULAR)

      expect(Frame.count).to eq(1)
      expect(result.created_at).to_not eq(nil)
      expect(result.game_id).to eq(game.id)
      expect(result.id).to_not eq(nil)
      expect(result.kind).to eq('regular')
      expect(result.rolls).to eq([])
      expect(result.updated_at).to_not eq(nil)
    end
  end

  def create_frame
    model = FactoryBot.create(:frame)

    Constructors::Frame.new(model).call
  end

  def create_game
    model = FactoryBot.create(:game)

    Entities::Game.new(model)
  end
end
