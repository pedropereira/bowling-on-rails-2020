# frozen_string_literal: true

class FrameSerializer
  include FastJsonapi::ObjectSerializer

  has_many :rolls
end
