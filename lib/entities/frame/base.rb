# frozen_string_literal: true

module Entities
  module Frame
    class Base < Entities::Base
      attr_reader :created_at
      attr_reader :game_id
      attr_reader :kind
      attr_reader :updated_at

      def initialize(created_at:, id:, game_id:, kind:, updated_at:)
        @created_at = created_at
        @game_id = game_id
        @kind = kind
        @updated_at = updated_at

        super(id: id)
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
