# frozen_string_literal: true

module Repositories
  class Roll
    attr_reader :db

    def initialize(params = {})
      @db = params.fetch(:db) { ::Roll }
    end

    def all(filters = {})
      db.where(filters)
    end

    def create(attributes = {})
      db.create!(attributes)
    end
  end
end
