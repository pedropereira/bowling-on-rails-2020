# frozen_string_literal: true

module UseCases
  class CalculateScore
    def call(frames)
      frames.each_with_index.reduce(0) do |sum, (frame, index)|
        frame_score(frames, sum, frame, index)
      end
    end

    private

    def frame_score(frames, sum, frame, index)
      if frame.strike?
        sum + pinfall(frame) + pinfall_from_next_two_rolls(frames, index)
      elsif frame.spare?
        sum + pinfall(frame) + pinfall_from_next_roll(frames, index)
      else
        sum + pinfall(frame)
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
      @roll_repository ||= RollRepository.new
    end

    def subsequent_rolls(frames, index)
      frame_ids = frames.map(&:id)[(index + 1)..]

      roll_repository.all(frame_id: frame_ids).order(:created_at)
    end
  end
end
