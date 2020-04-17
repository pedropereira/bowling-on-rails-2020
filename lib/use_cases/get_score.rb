# frozen_string_literal: true

module UseCases
  class GetScore
    def call(id)
      game = game_repository.find(id)

      Serializers::Score.new(game).call
    end

    private

    def game_repository
      @game_repository ||= Repositories::Game.new
    end
  end
end
