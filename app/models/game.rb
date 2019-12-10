# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :frames

  FINISHED = 'finished'
  ONGOING = 'ongoing'
end
