# frozen_string_literal: true

class GameDecorator
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def roll(pins)
    return false if game.state == Game::FINISHED

    current_frame.roll(pins)

    true
  end

  def frames
    frames = frame_repository.all(game_id: game.id).order(:created_at)

    [
      ::Frame::RegularDecorator.new(game: game, frame: frames[0] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[1] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[2] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[3] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[4] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[5] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[6] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[7] || build_frame),
      ::Frame::RegularDecorator.new(game: game, frame: frames[8] || build_frame),
      ::Frame::TenthDecorator.new(game: game, frame: frames[9] || build_frame)
    ]
  end

  private

  def build_frame
    frame_repository.build(game_id: game.id)
  end

  def current_frame
    frames.select(&:persisted?).last
  end

  def frame_repository
    @frame_repository ||= FrameRepository.new
  end
end
