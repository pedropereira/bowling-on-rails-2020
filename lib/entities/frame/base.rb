# frozen_string_literal: true

module Entities
  module Frame
    class Base
      attr_reader :frame, :game

      delegate :id, :created_at, :persisted?, to: :frame

      def initialize(frame)
        @frame = frame
        @game = frame.game
      end

      def rolls
        frame.rolls.order(:created_at)
      end

      def rolls_done?(number)
        rolls.size == number
      end

      private

      def game_repository
        @game_repository ||= Repositories::Game.new
      end

      def frame_repository
        @frame_repository ||= Repositories::Frame.new
      end

      def roll_repository
        @roll_repository ||= Repositories::Roll.new
      end
    end
  end
end
