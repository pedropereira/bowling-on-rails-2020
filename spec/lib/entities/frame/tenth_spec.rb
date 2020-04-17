# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::Frame::Tenth do
  describe '#roll' do
    it 'produces a strike' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      entity.roll(10)

      expect(entity.strike?).to eq(true)
      expect(entity.rolls.count).to eq(1)
    end

    it 'produces a spare' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      entity.roll(2)
      entity.roll(8)

      expect(entity.spare?).to eq(true)
      expect(entity.rolls.count).to eq(2)
    end

    it 'produces one roll' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      entity.roll(9)

      expect(entity.open?).to eq(true)
      expect(entity.rolls.count).to eq(1)
    end

    it 'produces two rolls' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      entity.roll(7)
      entity.roll(2)

      expect(entity.open?).to eq(true)
      expect(entity.rolls.count).to eq(2)
    end

    it 'produces three rolls' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      entity.roll(10)
      entity.roll(10)
      entity.roll(10)

      expect(entity.strike?).to eq(true)
      expect(entity.rolls.count).to eq(3)
    end
  end

  describe '#open?' do
    it 'returns true for no rolls' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      result = entity.open?

      expect(result).to eq(true)
    end

    it 'returns true for one roll' do
      model = FactoryBot.create(:frame, rolls: [FactoryBot.create(:roll, pins: 1)])
      entity = described_class.new(model)

      result = entity.open?

      expect(result).to eq(true)
    end

    it 'returns true for two rolls' do
      model = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1), FactoryBot.create(:roll, pins: 2)]
      )
      entity = described_class.new(model)

      result = entity.open?

      expect(result).to eq(true)
    end

    it 'returns false for a strike' do
      model = FactoryBot.create(:frame, rolls: [FactoryBot.create(:roll, pins: 10)])
      entity = described_class.new(model)

      result = entity.open?

      expect(result).to eq(false)
    end

    it 'returns false for a spare' do
      model = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      entity = described_class.new(model)

      result = entity.open?

      expect(result).to eq(false)
    end
  end

  describe '#strike?' do
    it 'returns true' do
      model = FactoryBot.create(:frame, rolls: [FactoryBot.create(:roll, pins: 10)])
      entity = described_class.new(model)

      result = entity.strike?

      expect(result).to eq(true)
    end

    it 'returns false for no rolls' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      result = entity.strike?

      expect(result).to eq(false)
    end

    it 'returns false for one roll' do
      model = FactoryBot.create(:frame, rolls: [FactoryBot.create(:roll, pins: 1)])
      entity = described_class.new(model)

      result = entity.strike?

      expect(result).to eq(false)
    end

    it 'returns false for two rolls' do
      model = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1), FactoryBot.create(:roll, pins: 2)]
      )
      entity = described_class.new(model)

      result = entity.strike?

      expect(result).to eq(false)
    end

    it 'returns false for a spare' do
      model = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      entity = described_class.new(model)

      result = entity.strike?

      expect(result).to eq(false)
    end
  end

  describe '#spare?' do
    it 'returns true' do
      model = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      entity = described_class.new(model)

      result = entity.spare?

      expect(result).to eq(true)
    end

    it 'returns false for no rolls' do
      model = FactoryBot.create(:frame)
      entity = described_class.new(model)

      result = entity.spare?

      expect(result).to eq(false)
    end

    it 'returns false for one roll' do
      model = FactoryBot.create(:frame, rolls: [FactoryBot.create(:roll, pins: 1)])
      entity = described_class.new(model)

      result = entity.spare?

      expect(result).to eq(false)
    end

    it 'returns false for two rolls' do
      model = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1), FactoryBot.create(:roll, pins: 2)]
      )
      entity = described_class.new(model)

      result = entity.spare?

      expect(result).to eq(false)
    end

    it 'returns false for a strike' do
      model = FactoryBot.create(:frame, rolls: [FactoryBot.create(:roll, pins: 10)])
      entity = described_class.new(model)

      result = entity.spare?

      expect(result).to eq(false)
    end
  end
end
