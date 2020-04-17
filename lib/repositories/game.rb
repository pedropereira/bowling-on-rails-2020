# frozen_string_literal: true

module Repositories
  class Game
    attr_reader :db
    attr_reader :entity

    def initialize(db: ::Game, entity: Entities::Game)
      @db = db
      @entity = entity
    end

    def create(attributes = {})
      model = db.create!(attributes)

      entity.new(model)
    end

    def find(id)
      model = db.find(id)

      entity.new(model)
    end

    def update(game, attributes)
      model = db.update(game.id, attributes)

      entity.new(model)
    end
  end
end
