# frozen_string_literal: true

require "rails_helper"

RSpec.describe Entities::Frame::Base do
  describe "#rolls" do
    it "returns rolls that belong the frame" do
      attributes = create_frame
      roll1 = create_roll(frame_id: attributes[:id])
      roll2 = create_roll(frame_id: attributes[:id])
      create_roll
      entity = described_class.new(attributes)

      result = entity.rolls

      expect(result).to eq([roll1, roll2])
    end
  end

  describe "#rolls_done?" do
    it "returns true" do
      attributes = create_frame(rolls: [FactoryBot.create(:roll), FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.rolls_done?(2)

      expect(result).to eq(true)
    end

    it "returns false" do
      attributes = create_frame(rolls: [FactoryBot.create(:roll)])
      entity = described_class.new(attributes)

      result = entity.rolls_done?(2)

      expect(result).to eq(false)
    end
  end

  def create_frame(params = {})
    model = FactoryBot.create(:frame, params)

    Serializers::Db::Frame.new.from(model)
  end

  def create_roll(params = {})
    model = FactoryBot.create(:roll, params)
    attributes = Serializers::Db::Roll.new.from(model)

    Entities::Roll.new(attributes)
  end
end
