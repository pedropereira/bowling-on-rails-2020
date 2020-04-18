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
      attributes = attributes_from(model)

      entity.new(attributes)
    end

    def find(id)
      model = db.find(id)
      attributes = attributes_from(model)

      entity.new(attributes)
    end

    def update(game_id, attributes)
      model = db.update(game_id, attributes)
      attributes = attributes_from(model)

      entity.new(attributes)
    end

    private

    def attributes_from(model)
      Serializers::Db::Game.new.from(model)
    end
  end
end
