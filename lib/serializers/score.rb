# frozen_string_literal: true

module Serializers
  class Score
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def call
      game_payload(game)
    end

    private

    def game_payload(game)
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
              "data": frames_payload(game.frames)
            }
          }
        }
      }
    end

    def frames_payload(frames)
      frames.map do |frame|
        {
          "id": frame.id,
          "type": 'frame',
          "attributes": {
            "score": Services::CalculateScore.new.for_frame(frame)
          },
          "relationships": {
            "rolls": {
              "data": rolls_payload(frame.rolls)
            }
          }
        }
      end
    end

    def rolls_payload(rolls)
      rolls.map do |roll|
        {
          "id": roll.id,
          "type": 'roll',
          "attributes": {
            "pins": roll.pins
          }
        }
      end
    end
  end
end
