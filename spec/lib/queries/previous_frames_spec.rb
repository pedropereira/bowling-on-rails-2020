# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::PreviousFrames do
  describe '#call' do
    it 'returns the previous frames relative to the current frame' do
      game = create_game
      frame1 = create_frame(game_id: game.id, created_at: Time.now - 2.minutes)
      frame2 = create_frame(game_id: game.id, created_at: Time.now - 1.minute)
      frame3 = create_frame(game_id: game.id)
      previous_frames = described_class.new(frame3)

      result = previous_frames.call

      expect(result).to eq([frame1, frame2])
    end
  end

  def create_game
    model = FactoryBot.create(:game)

    Entities::Game.new(model)
  end

  def create_frame(params = {})
    model = FactoryBot.create(:frame, params)

    Constructors::Frame.new(model).call
  end
end
