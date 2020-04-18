# frozen_string_literal: true

module API
  module V1
    class StartController < ApplicationController
      def call
        game = UseCases::StartGame.new.call

        render_ok(serialize(game))
      end

      private

      def serialize(game)
        Serializers::Json::Game.new(game).to
      end
    end
  end
end
