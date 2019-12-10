# frozen_string_literal: true

class GameDecorator
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def frames
    frame_repository.all(game_id: game.id).order(:created_at)
  end

  def roll(pins)
    return false if game.state == Game::FINISHED

    frame = current_frame
    frame.roll(pins)

    if tenth_frame?
      game_repository.update(game, state: Game::FINISHED) if game_finished?(frame)
    elsif frame_finished?(frame)
      frame_repository.create(game_id: game.id)
    end

    true
  end

  private

  def current_frame
    frame = frames.last || frame_repository.create(game_id: game.id)

    FrameDecorator.new(frame)
  end

  def frame_finished?(frame)
    (frame.open? && frame.rolls_done?(2)) ||
      frame.strike? ||
      frame.spare?
  end

  def frame_repository
    @frame_repository ||= FrameRepository.new
  end

  def game_finished?(frame)
    (frame.strike? && frame.rolls_done?(3)) ||
      (frame.spare? && frame.rolls_done?(3)) ||
      (frame.open? && frame.rolls_done?(2))
  end

  def game_repository
    @game_repository ||= GameRepository.new
  end

  def tenth_frame?
    frames.size == 10
  end
end
