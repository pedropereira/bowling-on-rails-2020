# frozen_string_literal: true

class GameStartController < ApplicationController
  def call
    game = StartGame.new.call

    render json: serialize(game), status: 200, content_type: 'application/vnd.api+json'
  end

  private

  def serialize(game)
    GameSerializer.new(game).serialized_json
  end
end
