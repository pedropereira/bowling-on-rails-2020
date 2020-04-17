# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Roll do
  describe '#all' do
    it 'returns all rolls' do
      roll1 = create_roll
      roll2 = create_roll
      repository = described_class.new

      result = repository.all

      expect(result).to eq([roll1, roll2])
    end

    it 'returns filtered rolls' do
      frame_id = FactoryBot.create(:frame).id
      create_roll
      roll = create_roll(frame_id: frame_id)
      repository = described_class.new

      result = repository.all(filters: { frame_id: frame_id })

      expect(result).to eq([roll])
    end
  end

  describe '#create' do
    it 'creates a new roll' do
      frame = FactoryBot.create(:frame)
      repository = described_class.new

      result = repository.create(frame_id: frame.id, pins: 10)

      expect(Roll.count).to eq(1)
      expect(result.created_at).to_not eq(nil)
      expect(result.frame_id).to eq(frame.id)
      expect(result.pins).to eq(10)
      expect(result.updated_at).to_not eq(nil)
    end
  end

  def create_roll(params = {})
    model = FactoryBot.create(:roll, params)

    Entities::Roll.new(model)
  end
end
