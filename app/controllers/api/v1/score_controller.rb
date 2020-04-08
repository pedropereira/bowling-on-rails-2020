# frozen_string_literal: true

module API
  module V1
    class ScoreController < ApplicationController
      def call
        game = UseCases::GetScore.new.call(params[:id])

        render json: game, status: 200, content_type: 'application/vnd.api+json'
      end
    end
  end
end
