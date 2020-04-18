# frozen_string_literal: true

module Serializers
  module Json
    class Game
      attr_reader :game

      def initialize(game)
        @game = game
      end

      # rubocop:disable Metrics/MethodLength
      def to
        {
          "data": {
            "id": game.id,
            "type": 'game',
            "attributes": {
              "state": game.state,
              "score": Services::CalculateScore.new.for_game(game)
            },
            "relationships": {
              "frames": {
                "data": game.frames.map { |frame| Serializers::Json::Frame.new(frame).to }
              }
            }
          }
        }
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
