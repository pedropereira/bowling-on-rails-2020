# frozen_string_literal: true

module Queries
  class PreviousFrames
    attr_reader :frame
    attr_reader :game

    def initialize(frame)
      @frame = frame
      @game = frame.game
    end

    def call
      frame_repository.all(filters: "game_id = #{game.id} and created_at < '#{frame.created_at}'")
    end

    private

    def frame_repository
      @frame_repository ||= Repositories::Frame.new
    end
  end
end
