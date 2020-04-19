# frozen_string_literal: true

module Forms
  class Errors
    attr_reader :errors

    def initialize(errors = {})
      @errors = errors
    end

    def add(error)
      errors.merge!(error)
    end

    def empty?
      errors.empty?
    end

    def to_s
      errors.map { |key, message| [key, message].join(" ") }.join(", ")
    end
  end
end
