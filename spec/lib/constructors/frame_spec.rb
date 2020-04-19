# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Constructors::Frame do
  describe '#call' do
    it 'returns the regular frame entity' do
      attributes = build_stubbed(kind: Entities::Frame::REGULAR)
      frame = Entities::Frame::Regular.new(attributes)
      constructor = described_class.new(attributes)

      result = constructor.call

      expect(result).to eq(frame)
    end

    it 'returns the tenth frame entity' do
      attributes = build_stubbed(kind: Entities::Frame::TENTH)
      frame = Entities::Frame::Tenth.new(attributes)
      constructor = described_class.new(attributes)

      result = constructor.call

      expect(result).to eq(frame)
    end
  end

  def build_stubbed(params = {})
    model = FactoryBot.build_stubbed(:frame, params)

    Serializers::Db::Frame.new.from(model)
  end
end
