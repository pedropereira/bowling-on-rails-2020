# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Constructors::Frame do
  describe '#call' do
    it 'returns the regular frame entity' do
      model = FactoryBot.create(:frame, kind: Entities::Frame::REGULAR)
      attributes = Serializers::Db::Frame.new.from(model)
      frame = Entities::Frame::Regular.new(attributes)
      constructor = described_class.new(attributes)

      result = constructor.call

      expect(result).to eq(frame)
    end

    it 'returns the tenth frame entity' do
      model = FactoryBot.create(:frame, kind: Entities::Frame::TENTH)
      attributes = Serializers::Db::Frame.new.from(model)
      frame = Entities::Frame::Tenth.new(attributes)
      constructor = described_class.new(attributes)

      result = constructor.call

      expect(result).to eq(frame)
    end
  end
end
