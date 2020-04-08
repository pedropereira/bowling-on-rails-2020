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
        Serializers::Score.new(game).call
      end
    end
  end
end
