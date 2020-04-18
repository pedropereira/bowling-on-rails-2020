# frozen_string_literal: true

module Entities
  class Base
    attr_reader :id

    def initialize(id:)
      @id = id
    end

    def ==(other)
      self.class == other.class && id == other.id
    end
  end
end
