# frozen_string_literal: true

module Entities
  module Frame
    class Tenth < Entities::Frame::Base
      def roll(pins)
        roll_repository.create(frame_id: id, pins: pins)

        finish_game if finished?
      end

      def open?
        rolls.count <= 3 && rolls.map(&:pins).sum < 10
      end

      def spare?
        rolls.count >= 2 && rolls.map(&:pins).sum >= 10
      end

      def strike?
        rolls.count >= 1 && rolls.first.pins == 10
      end

      private

      def finished?
        (strike? && rolls_done?(3)) || (spare? && rolls_done?(3)) || (open? && rolls_done?(2))
      end

      def finish_game
        game_repository.update(game, state: Entities::Game::FINISHED)
      end
    end
  end
end
