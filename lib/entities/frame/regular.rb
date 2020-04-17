# frozen_string_literal: true

module Entities
  module Frame
    class Regular < Entities::Frame::Base
      def roll(pins)
        roll_repository.create(frame_id: id, pins: pins)

        start_new_frame if finished?
      end

      def open?
        rolls.count <= 2 && rolls.map(&:pins).sum < 10
      end

      def spare?
        rolls.count == 2 && rolls.map(&:pins).sum == 10
      end

      def strike?
        rolls.count == 1 && rolls.map(&:pins).sum == 10
      end

      private

      def finished?
        (open? && rolls_done?(2)) || strike? || spare?
      end

      # TODO: FIX THIS
      def start_new_frame
        frame_repository.create(game_id: game.id, kind: Entities::Frame::REGULAR)
      end
    end
  end
end
