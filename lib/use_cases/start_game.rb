# frozen_string_literal: true

class UseCases::StartGame
  def call
    game = game_repository.create
    frame_repository.create(game_id: game.id)

    game
  end

  private

  def frame_repository
    @frame_repository ||= FrameRepository.new
  end

  def game_repository
    @game_repository ||= GameRepository.new
  end
end
