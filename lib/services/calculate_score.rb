# frozen_string_literal: true

module Services
  class CalculateScore
    def for_game(game)
      for_frames(game.frames)
    end

    def for_frame(frame)
      frames = Queries::PreviousFrames.new(frame).call

      for_frames(frames)
    end

    private

    def for_frames(frames)
      frames.select(&:persisted?).each_with_index.reduce(0) do |sum, (frame, index)|
        frame_score(frame: frame, frames: frames, index: index, sum: sum)
      end
    end

    def frame_score(frame:, frames:, index:, sum:)
      current_pinfall = sum + pinfall(frame)

      if frame.strike?
        current_pinfall + pinfall_from_next_two_rolls(frames, index)
      elsif frame.spare?
        current_pinfall + pinfall_from_next_roll(frames, index)
      else
        current_pinfall
      end
    end

    def pinfall(frame)
      frame.rolls.map(&:pins).sum
    end

    def pinfall_from_next_roll(frames, index)
      rolls = subsequent_rolls(frames, index)

      rolls.first&.pins || 0
    end

    def pinfall_from_next_two_rolls(frames, index)
      rolls = subsequent_rolls(frames, index).first(2)

      rolls.map(&:pins).sum
    end

    def roll_repository
      @roll_repository ||= Repositories::Roll.new
    end

    def subsequent_rolls(frames, index)
      frame_ids = frames.map(&:id)[(index + 1)..]

      roll_repository.all(filters: {frame_id: frame_ids}, order: {created_at: :asc})
    end
  end
end
