# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FrameDecorator do
  describe '#roll' do
    it 'produces a strike' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame)

      decorator.roll(10)

      expect(frame.state).to eq('strike')
      expect(frame.rolls.count).to eq(1)
    end

    it 'produces a spare' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame)

      decorator.roll(2)
      decorator.roll(8)

      expect(frame.state).to eq('spare')
      expect(frame.rolls.count).to eq(2)
    end

    it 'produces a single roll' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame)

      decorator.roll(9)

      expect(frame.state).to eq('open')
      expect(frame.rolls.count).to eq(1)
    end

    it 'produces two rolls' do
      frame = FactoryBot.create(:frame)
      decorator = described_class.new(frame)

      decorator.roll(7)
      decorator.roll(2)

      expect(frame.state).to eq('open')
      expect(frame.rolls.count).to eq(2)
    end
  end

  describe '#open?' do
    it 'returns true' do
      frame = FactoryBot.create(:frame, state: 'open')
      decorator = described_class.new(frame)

      result = decorator.open?

      expect(result).to eq(true)
    end

    it 'returns false' do
      frame = FactoryBot.create(:frame, state: 'spare')
      decorator = described_class.new(frame)

      result = decorator.open?

      expect(result).to eq(false)
    end
  end

  describe '#strike?' do
    it 'returns true' do
      frame = FactoryBot.create(:frame, state: 'strike')
      decorator = described_class.new(frame)

      result = decorator.strike?

      expect(result).to eq(true)
    end

    it 'returns false' do
      frame = FactoryBot.create(:frame, state: 'open')
      decorator = described_class.new(frame)

      result = decorator.strike?

      expect(result).to eq(false)
    end
  end

  describe '#spare?' do
    it 'returns true' do
      frame = FactoryBot.create(:frame, state: 'spare')
      decorator = described_class.new(frame)

      result = decorator.spare?

      expect(result).to eq(true)
    end

    it 'returns false' do
      frame = FactoryBot.create(:frame, state: 'open')
      decorator = described_class.new(frame)

      result = decorator.spare?

      expect(result).to eq(false)
    end
  end
end
