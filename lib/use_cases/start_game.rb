# frozen_string_literal: true

module UseCases
  class StartGame
    def call
      model = game_repository.create
      frame_repository.create(game_id: model.id)

      Entities::Game.new(model)
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
