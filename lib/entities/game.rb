# frozen_string_literal: true

module Entities
  class Game < Base
    delegate :created_at,
             :state,
             :updated_at,
             to: :model

    FINISHED = 'finished'
    ONGOING = 'ongoing'

    def frames
      frames = frame_repository.all(filters: { game_id: id }, order: { created_at: :asc })

      regular_frames(frames) + [tenth_frame(frames)]
    end

    def roll(pins)
      return false if state == FINISHED

      current_frame.roll(pins)

      true
    end

    private

    def build_frame(kind:)
      frame_repository.build(game_id: id, kind: kind)
    end

    def current_frame
      frames.select(&:persisted?).last
    end

    def frame_repository
      @frame_repository ||= Repositories::Frame.new
    end

    def regular_frames(frames)
      9.times.map do |i|
        Entities::Frame::Regular.new(frames[i] || build_frame(kind: Entities::Frame::REGULAR))
      end
    end

    def tenth_frame(frames)
      Entities::Frame::Tenth.new(frames[9] || build_frame(kind: Entities::Frame::TENTH))
    end
  end
end
