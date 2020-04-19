# frozen_string_literal: true

require "rails_helper"

RSpec.describe Entities::Base do
  describe "#==" do
    it "returns true" do
      entity1 = described_class.new(id: 1)
      entity2 = described_class.new(id: 1)

      result = entity1 == entity2

      expect(result).to eq(true)
    end

    it "returns false" do
      entity1 = described_class.new(id: 1)
      entity2 = described_class.new(id: 2)

      result = entity1 == entity2

      expect(result).to eq(false)
    end
  end
end
