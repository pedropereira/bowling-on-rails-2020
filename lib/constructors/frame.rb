# frozen_string_literal: true

module Constructors
  class Frame
    def initialize(model)
      @model = model
    end

    def call
      "Entities::Frame::#{@model.kind.capitalize}".constantize.new(@model)
    end
  end
end
