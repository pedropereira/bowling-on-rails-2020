# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::Frame::Regular do
  describe '#roll' do
    it 'produces a strike' do
      attributes = create_frame
      entity = described_class.new(attributes)

      entity.roll(10)

      expect(entity.strike?).to eq(true)
      expect(entity.rolls.count).to eq(1)
    end

    it 'produces a spare' do
      attributes = create_frame
      entity = described_class.new(attributes)

      entity.roll(2)
      entity.roll(8)

      expect(entity.spare?).to eq(true)
      expect(entity.rolls.count).to eq(2)
    end

    it 'produces one roll' do
      attributes = create_frame
      entity = described_class.new(attributes)

      entity.roll(9)

      expect(entity.open?).to eq(true)
      expect(entity.rolls.count).to eq(1)
    end

    it 'produces two rolls' do
      attributes = create_frame
      entity = described_class.new(attributes)

      entity.roll(7)
      entity.roll(2)

      expect(entity.open?).to eq(true)
      expect(entity.rolls.count).to eq(2)
    end
  end

  describe '#open?' do
    it 'returns true for no rolls' do
      attributes = create_frame
      entity = described_class.new(attributes)

      result = entity.open?

      expect(result).to eq(true)
    end

    it 'returns true for one roll' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.open?

      expect(result).to eq(true)
    end

    it 'returns true for two rolls' do
      attributes = create_frame(
        rolls: [FactoryBot.create(:roll), FactoryBot.create(:roll)]
      )
      entity = described_class.new(attributes)
      result = entity.open?

      expect(result).to eq(true)
    end

    it 'returns false for a strike' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll, pins: 10)])
      entity = described_class.new(attributes)

      result = entity.open?

      expect(result).to eq(false)
    end

    it 'returns false for a spare' do
      attributes = create_frame(
        rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      entity = described_class.new(attributes)

      result = entity.open?

      expect(result).to eq(false)
    end
  end

  describe '#strike?' do
    it 'returns true' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll, pins: 10)])
      entity = described_class.new(attributes)

      result = entity.strike?

      expect(result).to eq(true)
    end

    it 'returns false for no rolls' do
      attributes = create_frame
      entity = described_class.new(attributes)

      result = entity.strike?

      expect(result).to eq(false)
    end

    it 'returns false for one roll' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.strike?

      expect(result).to eq(false)
    end

    it 'returns false for two rolls' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll), FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.strike?

      expect(result).to eq(false)
    end

    it 'returns false for a spare' do
      attributes = create_frame(
        rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      entity = described_class.new(attributes)

      result = entity.strike?

      expect(result).to eq(false)
    end
  end

  describe '#spare?' do
    it 'returns true' do
      attributes = create_frame(
        rolls: [FactoryBot.create(:roll, pins: 5), FactoryBot.create(:roll, pins: 5)]
      )
      entity = described_class.new(attributes)

      result = entity.spare?

      expect(result).to eq(true)
    end

    it 'returns false for no rolls' do
      attributes = create_frame
      entity = described_class.new(attributes)

      result = entity.spare?

      expect(result).to eq(false)
    end

    it 'returns false for one roll' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.spare?

      expect(result).to eq(false)
    end

    it 'returns false for two rolls' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll), FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.spare?

      expect(result).to eq(false)
    end

    it 'returns false for a strike' do
      attributes = create_frame(rolls: [FactoryBot.create(:roll, pins: 10)])
      entity = described_class.new(attributes)

      result = entity.spare?

      expect(result).to eq(false)
    end
  end

  def create_frame(params = {})
    model = FactoryBot.create(:frame, params)

    Serializers::Db::Frame.new.from(model)
  end
end
