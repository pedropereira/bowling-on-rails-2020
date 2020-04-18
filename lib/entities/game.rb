# frozen_string_literal: true

module Entities
  class Game < Base
    FINISHED = 'finished'
    ONGOING = 'ongoing'

    attr_reader :created_at
    attr_reader :state
    attr_reader :updated_at

    def initialize(created_at:, id:, state:, updated_at:)
      @created_at = created_at
      @state = state
      @updated_at = updated_at

      super(id: id)
    end

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
      frames.select(&:id).last
    end

    def frame_repository
      @frame_repository ||= Repositories::Frame.new
    end

    def regular_frames(frames)
      9.times.map do |index|
        frames[index] || build_frame(kind: Entities::Frame::REGULAR)
      end
    end

    def tenth_frame(frames)
      frames[9] || build_frame(kind: Entities::Frame::TENTH)
    end
  end
end
