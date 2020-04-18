# frozen_string_literal: true

module UseCases
  class GetScore
    def call(id)
      game = game_repository.find(id)

      Serializers::Json::Game.new(game).to
    end

    private

    def game_repository
      @game_repository ||= Repositories::Game.new
    end
  end
end
