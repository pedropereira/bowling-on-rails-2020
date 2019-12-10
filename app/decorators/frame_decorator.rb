# frozen_string_literal: true

class FrameDecorator
  attr_reader :frame

  delegate :persisted?, to: :frame

  def initialize(frame)
    @frame = frame
  end

  def open?
    frame.state == Frame::OPEN
  end

  def roll(pins)
    set_strike_or_spare(frame, pins)

    roll_repository.create(frame_id: frame.id, pins: pins)
  end

  def spare?
    frame.state == Frame::SPARE
  end

  def strike?
    frame.state == Frame::STRIKE
  end

  def rolls_done?(number)
    rolls.size == number
  end

  private

  def first_roll
    rolls.first
  end

  def first_roll?
    rolls_done?(0)
  end

  def frame_repository
    @frame_repository ||= FrameRepository.new
  end

  def roll_repository
    @roll_repository ||= RollRepository.new
  end

  def rolls
    roll_repository.all(frame_id: frame.id).order(:created_at)
  end

  def second_roll?
    rolls_done?(1)
  end

  def set_strike_or_spare(frame, pins)
    if first_roll? && pins == 10
      frame_repository.update(frame, state: Frame::STRIKE)
    elsif second_roll? && pins + first_roll.pins == 10
      frame_repository.update(frame, state: Frame::SPARE)
    end
  end
end
