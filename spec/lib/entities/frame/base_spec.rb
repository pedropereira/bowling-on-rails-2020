# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::Frame::Base do
  describe '#rolls' do
    it 'returns rolls that belong the frame' do
      frame_model = FactoryBot.create(:frame)
      roll1 = create_roll(frame_id: frame_model.id)
      roll2 = create_roll(frame_id: frame_model.id)
      create_roll
      entity = described_class.new(frame_model)

      result = entity.rolls

      expect(result).to eq([roll1, roll2])
    end
  end

  describe '#rolls_done?' do
    it 'returns true' do
      frame_model = FactoryBot.create(:frame)
      create_roll(frame_id: frame_model.id)
      create_roll(frame_id: frame_model.id)
      entity = described_class.new(frame_model)

      result = entity.rolls_done?(2)

      expect(result).to eq(true)
    end

    it 'returns false' do
      frame_model = FactoryBot.create(:frame)
      create_roll(frame_id: frame_model.id)
      entity = described_class.new(frame_model)

      result = entity.rolls_done?(2)

      expect(result).to eq(false)
    end
  end

  def create_roll(params = {})
    model = FactoryBot.create(:roll, params)

    Entities::Roll.new(model)
  end
end
