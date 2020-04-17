# frozen_string_literal: true

module UseCases
  class StartGame
    def call
      game = game_repository.create
      frame_repository.create(game_id: game.id, kind: 'regular')

      game
    end

    private

    def frame_repository
      @frame_repository ||= Repositories::Frame.new
    end

    def game_repository
      @game_repository ||= Repositories::Game.new
    end
  end
end
