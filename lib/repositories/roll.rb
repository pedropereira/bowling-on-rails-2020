# frozen_string_literal: true

module Repositories
  class Roll
    attr_reader :db
    attr_reader :entity

    def initialize(db: ::Roll, entity: Entities::Roll)
      @db = db
      @entity = entity
    end

    def all(filters: {}, order: {})
      models = db.where(filters)
      models = models.order(order) if order.present?

      models.map do |model|
        entity.new(model)
      end
    end

    def create(attributes = {})
      model = db.create!(attributes)

      entity.new(model)
    end
  end
end
