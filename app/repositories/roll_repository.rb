# frozen_string_literal: true

class RollRepository
  def all(attributes = {})
    Roll.where(attributes)
  end

  def create(attributes = nil)
    Roll.create!(attributes)
  end
end
