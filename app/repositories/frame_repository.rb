# frozen_string_literal: true

class FrameRepository
  def all(attributes = {})
    Frame.where(attributes)
  end

  def build(attributes = {})
    Frame.new(attributes)
  end

  def create(attributes = nil)
    Frame.create!(attributes)
  end

  def update(frame, attributes)
    frame.update!(attributes)
  end
end
