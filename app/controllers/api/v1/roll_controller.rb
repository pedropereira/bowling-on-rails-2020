# frozen_string_literal: true

module API
  module V1
    class RollController < ApplicationController
      def call
        game = Forms::Roll.new(permitted_params).call

        if game
          render json: serialize(game), status: 200, content_type: 'application/vnd.api+json'
        else
          render_422(form.errors)
        end
      end

      private

      def permitted_params
        params.permit(:id, :pins).to_h
      end

      def serialize(game)
        Serializers::Score.new(game).call
      end
    end
  end
end
