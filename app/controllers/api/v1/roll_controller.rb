# frozen_string_literal: true

module API
  module V1
    class RollController < ApplicationController
      def call
        form = Forms::Roll.new(permitted_params)
        game = form.call

        if game
          render_ok(serialize(game))
        else
          render_unprocessable(form.errors)
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
