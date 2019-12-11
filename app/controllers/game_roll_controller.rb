# frozen_string_literal: true

class GameRollController < ApplicationController
  def call
    form = GameRollForm.new(id: params[:id], pins: params[:pins])
    result = form.call

    if result
      render json: serialize(result), status: 200, content_type: 'application/vnd.api+json'
    else
      render_422(form.error_messages)
    end
  end

  private

  def serialize(game)
    GameSerializer.new(game).serialized_json
  end
end
