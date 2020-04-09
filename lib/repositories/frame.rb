# frozen_string_literal: true

module Repositories
  class Frame
    attr_reader :db

    def initialize(params = {})
      @db = params.fetch(:db) { ::Frame }
    end

    def all(filters = {})
      db.where(filters)
    end

    def build(attributes = {})
      db.new(attributes)
    end

    def create(attributes = {})
      db.create!(attributes)
    end
  end
end
