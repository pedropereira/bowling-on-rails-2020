# frozen_string_literal: true

module API
  module V1
    class ScoreController < ApplicationController
      def call
        game = UseCases::GetScore.new.call(params[:id])

        render_ok(game)
      end
    end
  end
end
