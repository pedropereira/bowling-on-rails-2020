# frozen_string_literal: true

module API
  module V1
    class StartController < ApplicationController
      def call
        game = UseCases::StartGame.new.call

        render json: serialize(game), status: 200, content_type: 'application/vnd.api+json'
      end

      private

      def serialize(game)
        GameSerializer.new(game).serialized_json
      end
    end
  end
end
