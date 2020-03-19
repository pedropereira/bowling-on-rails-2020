# frozen_string_literal: true

class Frame::TenthDecorator < Frame::Base
  def roll(pins)
    roll_repository.create(frame_id: frame.id, pins: pins)

    finish_game if finished?
  end

  def open?
    rolls.count <= 3 && rolls.map(&:pins).sum < 10
  end

  def spare?
    rolls.count >= 2 && rolls.map(&:pins).sum >= 10
  end

  def strike?
    rolls.count >= 2 && rolls.first.pins == 10
  end

  private

  def finished?
    (strike? && rolls_done?(3)) || (spare? && rolls_done?(3)) || (open? && rolls_done?(2))
  end

  def finish_game
    game_repository.update(game, state: Game::FINISHED)
  end
end
