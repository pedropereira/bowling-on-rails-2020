# frozen_string_literal: true

class GameRepository
  def create(attributes = nil)
    Game.create!(attributes)
  end

  def find(id)
    Game.find(id)
  end

  def update(game, attributes)
    game.update!(attributes)
  end
end
