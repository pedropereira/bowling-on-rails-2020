# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RollRepository do
  describe '#all' do
    it 'returns all rolls' do
      roll1 = FactoryBot.create(:roll)
      roll2 = FactoryBot.create(:roll)

      result = described_class.new.all

      expect(result).to eq([roll1, roll2])
    end

    it 'returns filtered rolls' do
      frame = FactoryBot.create(:frame)
      FactoryBot.create(:roll)
      roll = FactoryBot.create(:roll, frame_id: frame.id)

      result = described_class.new.all(frame_id: frame.id)

      expect(result).to eq([roll])
    end
  end

  describe '#create' do
    it 'creates a new roll' do
      frame = FactoryBot.create(:frame)

      result = described_class.new.create(frame_id: frame.id)

      expect(Roll.count).to eq(1)
      expect(result.created_at).to_not eq(nil)
      expect(result.frame_id).to eq(frame.id)
      expect(result.pins).to eq(nil)
      expect(result.updated_at).to_not eq(nil)
    end
  end
end
