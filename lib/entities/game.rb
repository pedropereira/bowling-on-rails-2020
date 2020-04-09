# frozen_string_literal: true

module Entities
  class Game
    attr_reader :game

    delegate :id, :state, to: :game

    def initialize(game)
      @game = game
    end

    def frames
      frames = frame_repository.all(game_id: game.id).order(:created_at)

      regular_frames(frames) + [tenth_frame(frames)]
    end

    def roll(pins)
      return false if game.state == ::Game::FINISHED

      current_frame.roll(pins)

      true
    end

    private

    def build_frame
      frame_repository.build(game_id: game.id)
    end

    def current_frame
      frames.select(&:persisted?).last
    end

    def frame_repository
      @frame_repository ||= Repositories::Frame.new
    end

    def regular_frames(frames)
      9.times.map do |i|
        Entities::Frame::Regular.new(frames[i] || build_frame)
      end
    end

    def tenth_frame(frames)
      Entities::Frame::Tenth.new(frames[9] || build_frame)
    end
  end
end
