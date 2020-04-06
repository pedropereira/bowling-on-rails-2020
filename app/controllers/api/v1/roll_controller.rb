# frozen_string_literal: true

module API
  module V1
    class RollController < ApplicationController
      def call
        form = Forms::Roll.new(permitted_params)
        result = form.call

        if result
          render json: serialize(result), status: 200, content_type: 'application/vnd.api+json'
        else
          render_422(form.errors)
        end
      end

      private

      def permitted_params
        params.permit(:id, :pins).to_h
      end

      def serialize(game)
        GameSerializer.new(game).serialized_json
      end
    end
  end
end
