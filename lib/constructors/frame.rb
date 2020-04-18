# frozen_string_literal: true

module Constructors
  class Frame
    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def call
      "Entities::Frame::#{attributes[:kind].capitalize}".constantize.new(attributes)
    end
  end
end
