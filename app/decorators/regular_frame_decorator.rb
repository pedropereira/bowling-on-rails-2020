# frozen_string_literal: true

class RegularFrameDecorator
  attr_reader :frame, :game

  delegate :persisted?, to: :frame

  def initialize(params = {})
    @frame = FrameDecorator.new(params[:frame])
    @game = params[:game]
  end

  def roll(pins)
    frame.roll(pins)

    start_new_frame if finished?
  end

  private

  def finished?
    (frame.open? && frame.rolls_done?(2)) || frame.strike? || frame.spare?
  end

  def frame_repository
    @frame_repository ||= FrameRepository.new
  end

  def start_new_frame
    frame_repository.create(game_id: game.id)
  end
end
