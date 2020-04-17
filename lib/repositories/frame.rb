# frozen_string_literal: true

module Repositories
  class Frame
    attr_reader :db
    attr_reader :constructor

    def initialize(db: ::Frame, constructor: Constructors::Frame)
      @db = db
      @constructor = constructor
    end

    def all(filters: {}, order: {})
      models = db.where(filters)
      models = models.order(order) if order.present?

      models.map do |model|
        constructor.new(model).call
      end
    end

    def build(attributes = {})
      model = db.new(attributes)

      constructor.new(model).call
    end

    def create(attributes = {})
      model = db.create!(attributes)

      constructor.new(model).call
    end
  end
end
