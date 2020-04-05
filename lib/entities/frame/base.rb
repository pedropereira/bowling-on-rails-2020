# frozen_string_literal: true

module Entities
  module Frame
    class Base
      attr_reader :frame, :game

      delegate :id, :persisted?, to: :frame

      def initialize(params = {})
        @frame = params.fetch(:frame)
        @game = params.fetch(:game) { game_repository.create }
      end

      def rolls
        frame.rolls.order(:created_at)
      end

      def rolls_done?(number)
        rolls.size == number
      end

      private

      def game_repository
        @game_repository ||= GameRepository.new
      end

      def frame_repository
        @frame_repository ||= FrameRepository.new
      end

      def roll_repository
        @roll_repository ||= RollRepository.new
      end
    end
  end
end
