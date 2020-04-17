# frozen_string_literal: true

module Entities
  class Base
    delegate :id, to: :model

    def initialize(model)
      @model = model
    end

    def ==(other)
      self.class == other.class && id == other.id
    end

    private

    attr_reader :model
  end
end
