# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Constructors::Frame do
  describe '#call' do
    it 'returns the regular frame entity' do
      model = FactoryBot.create(:frame, kind: Entities::Frame::REGULAR)
      frame = Entities::Frame::Regular.new(model)
      constructor = described_class.new(model)

      result = constructor.call

      expect(result).to eq(frame)
    end

    it 'returns the tenth frame entity' do
      model = FactoryBot.create(:frame, kind: Entities::Frame::TENTH)
      frame = Entities::Frame::Tenth.new(model)
      constructor = described_class.new(model)

      result = constructor.call

      expect(result).to eq(frame)
    end
  end
end
