# frozen_string_literal: true

module Entities
  module Frame
    REGULAR = 'regular'
    TENTH = 'tenth'

    class Base < Entities::Base
      attr_reader :game

      delegate :created_at,
               :game_id,
               :kind,
               :persisted?,
               :updated_at,
               to: :model

      def initialize(model)
        super(model)
        @game = model.game
      end

      def rolls
        roll_repository.all(filters: { frame_id: id }, order: { created_at: :asc })
      end

      def rolls_done?(number)
        rolls.size == number
      end

      private

      def game_repository
        @game_repository ||= Repositories::Game.new
      end

      def frame_repository
        @frame_repository ||= Repositories::Frame.new
      end

      def roll_repository
        @roll_repository ||= Repositories::Roll.new
      end
    end
  end
end
