# frozen_string_literal: true

module Entities
  module Frame
    class Regular < Base
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

      def start_new_frame
        frames = frame_repository.all(filters: {game_id: game_id})
        kind = frames.count < 9 ? Entities::Frame::REGULAR : Entities::Frame::TENTH

        frame_repository.create(game_id: game_id, kind: kind)
      end
    end
  end
end
