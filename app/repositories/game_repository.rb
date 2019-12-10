# frozen_string_literal: true

class GameRepository
  def create(attributes = nil)
    Game.create!(attributes)
  end

  def update(game, attributes)
    game.update!(attributes)
  end
end
