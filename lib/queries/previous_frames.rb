# frozen_string_literal: true

module Queries
  class PreviousFrames
    attr_reader :frame

    def initialize(frame)
      @frame = frame
    end

    def call
      return [] unless frame.persisted?
      filters = "game_id = #{frame.game_id} and created_at < '#{frame.created_at}'"

      frame_repository.all(filters: filters)
    end

    private

    def frame_repository
      @frame_repository ||= Repositories::Frame.new
    end
  end
end
