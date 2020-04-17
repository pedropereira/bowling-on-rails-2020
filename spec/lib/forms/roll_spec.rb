# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forms::Roll do
  describe '#call' do
    it 'returns false if id is missing' do
      form = described_class.new(pins: '10')

      result = form.call

      expect(result).to eq(false)
    end

    it 'returns false if pins is missing' do
      form = described_class.new(id: 1)

      result = form.call

      expect(result).to eq(false)
    end

    it 'returns false if game is already finished' do
      game = FactoryBot.create(:game, state: Entities::Game::FINISHED)
      form = described_class.new(id: game.id)

      result = form.call

      expect(result).to eq(false)
    end

    it 'set error if id and pins are missing' do
      form = described_class.new

      form.call

      expect(form.errors).to eq('id is missing, pins is missing')
    end

    it 'set error if id is missing' do
      form = described_class.new(pins: 10)

      form.call

      expect(form.errors).to eq('id is missing')
    end

    it 'set error if id is not an integer' do
      form = described_class.new(id: 'a', pins: 10)

      form.call

      expect(form.errors).to eq('id must be an integer')
    end

    it 'set error if pins is missing' do
      form = described_class.new(id: 1)

      form.call

      expect(form.errors).to eq('pins is missing')
    end

    it 'set error if pins is not an integer' do
      form = described_class.new(id: 1, pins: 'a')

      form.call

      expect(form.errors).to eq('pins must be an integer')
    end

    it 'set error if pins is out of range I' do
      form = described_class.new(id: 1, pins: 12)

      form.call

      expect(form.errors).to eq('pins must be a value between 0 and 10')
    end

    it 'set error if pins is out of range II' do
      form = described_class.new(id: 1, pins: -1)

      form.call

      expect(form.errors).to eq('pins must be a value between 0 and 10')
    end

    it 'set error if game is already finished' do
      game = FactoryBot.create(:game, state: Entities::Game::FINISHED)
      form = described_class.new(id: game.id, pins: 10)

      form.call

      expect(form.errors).to eq('game is already finished')
    end

    it 'returns true if roll was successful' do
      game = FactoryBot.create(
        :game, state: Entities::Game::ONGOING, frames: [FactoryBot.create(:frame)]
      )
      form = described_class.new(id: game.id, pins: 10)

      result = form.call

      expect(result).to eq(game_id: game.id)
    end
  end
end
