# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Frame::RegularDecorator do
  describe '#roll' do
    it 'produces a strike' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      decorator.roll(10)

      expect(decorator.strike?).to eq(true)
      expect(decorator.rolls.count).to eq(1)
    end

    it 'produces a spare' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      decorator.roll(2)
      decorator.roll(8)

      expect(decorator.spare?).to eq(true)
      expect(decorator.rolls.count).to eq(2)
    end

    it 'produces one roll' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      decorator.roll(9)

      expect(decorator.open?).to eq(true)
      expect(decorator.rolls.count).to eq(1)
    end

    it 'produces two rolls' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      decorator.roll(7)
      decorator.roll(2)

      expect(decorator.open?).to eq(true)
      expect(decorator.rolls.count).to eq(2)
    end
  end

  describe '#open?' do
    it 'returns true for no rolls' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      result = decorator.open?

      expect(result).to eq(true)
    end

    it 'returns true for one roll' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.open?

      expect(result).to eq(true)
    end

    it 'returns true for two rolls' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1), FactoryBot.create(:roll, pins: 2)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.open?

      expect(result).to eq(true)
    end

    it 'returns false for a strike' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 10)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.open?

      expect(result).to eq(false)
    end

    it 'returns false for a spare' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.open?

      expect(result).to eq(false)
    end
  end

  describe '#strike?' do
    it 'returns true' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 10)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.strike?

      expect(result).to eq(true)
    end

    it 'returns false for no rolls' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      result = decorator.strike?

      expect(result).to eq(false)
    end

    it 'returns false for one roll' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.strike?

      expect(result).to eq(false)
    end

    it 'returns false for two rolls' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1), FactoryBot.create(:roll, pins: 2)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.strike?

      expect(result).to eq(false)
    end

    it 'returns false for a spare' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.strike?

      expect(result).to eq(false)
    end
  end

  describe '#spare?' do
    it 'returns true' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.spare?

      expect(result).to eq(true)
    end

    it 'returns false for no rolls' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame: frame)

      result = decorator.spare?

      expect(result).to eq(false)
    end

    it 'returns false for one roll' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.spare?

      expect(result).to eq(false)
    end

    it 'returns false for two rolls' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 1), FactoryBot.create(:roll, pins: 2)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.spare?

      expect(result).to eq(false)
    end

    it 'returns false for a strike' do
      frame = FactoryBot.create(
        :frame, rolls: [FactoryBot.create(:roll, pins: 10)]
      )
      decorator = described_class.new(frame: frame)

      result = decorator.spare?

      expect(result).to eq(false)
    end
  end
end
