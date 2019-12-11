# frozen_string_literal: true

class GameRollForm
  include ActiveModel::Model

  attr_accessor :id, :pins

  validates :id, presence: true
  validates :pins, presence: true, numericality: { only_integer: true }

  def call
    if valid?
      create_roll
    else
      false
    end
  end

  def error_messages
    errors.full_messages.join(', ')
  end

  def persisted?
    false
  end

  private

  def create_roll
    game = game_repository.find(id)
    game_decorator = GameDecorator.new(game)

    result = game_decorator.roll(pins.to_i)

    if result
      game
    else
      errors.add(:game, 'already finished')
      false
    end
  end

  def game_repository
    @game_repository ||= GameRepository.new
  end
end
