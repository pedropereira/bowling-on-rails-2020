# frozen_string_literal: true

class Frame::RegularDecorator < Frame::Base
  def roll(pins)
    roll_repository.create(frame_id: frame.id, pins: pins)

    start_new_frame if finished?
  end

  def rolls
    frame.rolls.order(:created_at)
  end

  def rolls_done?(number)
    rolls.size == number
  end

  def open?
    rolls.count <= 2 && rolls.map(&:pins).sum < 10
  end

  def spare?
    rolls.count == 2 && rolls.map(&:pins).sum == 10
  end

  def strike?
    rolls.count == 1 && rolls.map(&:pins).sum == 10
  end

  private

  def finished?
    (open? && rolls_done?(2)) || strike? || spare?
  end

  def start_new_frame
    frame_repository.create(game_id: game.id)
  end
end
