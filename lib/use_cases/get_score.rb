# frozen_string_literal: true

module UseCases
  class GetScore
    def call(id)
      model = game_repository.find(id)
      game = Entities::Game.new(model)

      Serializers::Score.new(game).call
    end

    private

    def game_repository
      @game_repository ||= Repositories::Game.new
    end
  end
end
