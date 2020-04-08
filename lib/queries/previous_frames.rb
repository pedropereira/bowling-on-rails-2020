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
      game.frames.where('created_at <= ?', frame.created_at).map do |frame|
        Entities::Frame::Regular.new(frame)
      end
    end
  end
end
