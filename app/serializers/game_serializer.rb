# frozen_string_literal: true

class GameSerializer
  include FastJsonapi::ObjectSerializer

  has_many :frames

  attributes :state
end
