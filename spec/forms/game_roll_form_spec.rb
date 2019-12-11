# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameRollForm do
  describe '#call' do
    it 'returns false if id is missing' do
      result = described_class.new(pins: '10').call

      expect(result).to eq(false)
    end

    it 'returns false if pins is missing' do
      result = described_class.new(id: '1').call

      expect(result).to eq(false)
    end

    it 'returns false if game is already finished' do
      game = FactoryBot.create(:game, state: 'finished')

      result = described_class.new(id: game.id).call

      expect(result).to eq(false)
    end

    it 'set error if id is missing' do
      form = described_class.new(pins: '10')

      form.call

      expect(form.errors.messages).to eq(id: ["can't be blank"])
    end

    it 'set error if pins is missing' do
      form = described_class.new(id: '1')

      form.call

      expect(form.errors.messages).to eq(pins: ["can't be blank", 'is not a number'])
    end

    it 'returns false if game is already finished' do
      game = FactoryBot.create(:game, state: 'finished')
      form = described_class.new(id: game.id, pins: '10')

      form.call

      expect(form.errors.messages).to eq(game: ['already finished'])
    end

    it 'returns the game if roll was successful' do
      game = FactoryBot.create(:game, state: 'ongoing', frames: [FactoryBot.create(:frame)])
      form = described_class.new(id: game.id, pins: '10')

      result = form.call

      expect(result).to eq(game)
    end
  end

  describe '#error_messages' do
    it 'returns joined error messages' do
      form = described_class.new

      form.call
      result = form.error_messages

      expect(result).to eq("Id can't be blank, Pins can't be blank, Pins is not a number")
    end
  end
end
