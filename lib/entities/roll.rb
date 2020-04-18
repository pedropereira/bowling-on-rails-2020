# frozen_string_literal: true

module Entities
  class Roll < Base
    attr_reader :created_at
    attr_reader :frame_id
    attr_reader :pins
    attr_reader :updated_at

    def initialize(created_at:, frame_id:, id:, pins:, updated_at:)
      @created_at = created_at
      @frame_id = frame_id
      @pins = pins
      @updated_at = updated_at

      super(id: id)
    end
  end
end
