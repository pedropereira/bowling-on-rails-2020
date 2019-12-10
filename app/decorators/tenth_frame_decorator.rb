# frozen_string_literal: true

class TenthFrameDecorator
  attr_reader :frame, :game

  delegate :persisted?, to: :frame

  def initialize(params = {})
    @frame = FrameDecorator.new(params[:frame])
    @game = params[:game]
  end

  def roll(pins)
    frame.roll(pins)

    finish_game if finished?
  end

  private

  def finished?
    (frame.strike? && frame.rolls_done?(3)) ||
      (frame.spare? && frame.rolls_done?(3)) ||
      (frame.open? && frame.rolls_done?(2))
  end

  def finish_game
    game_repository.update(game, state: Game::FINISHED)
  end

  def game_repository
    @game_repository ||= GameRepository.new
  end
end
