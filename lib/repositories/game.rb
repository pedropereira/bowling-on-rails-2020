# frozen_string_literal: true

module Repositories
  class Game
    attr_reader :db

    def initialize(params = {})
      @db = params.fetch(:db) { ::Game }
    end

    def create(attributes = {})
      db.create!(attributes)
    end

    def find(id)
      db.find(id)
    end

    def update(game, attributes)
      db.update(game.id, attributes)
    end
  end
end
