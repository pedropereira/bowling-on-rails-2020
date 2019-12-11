# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StartGame do
  describe '#call' do
    it 'creates a new game with a new frame' do
      described_class.new.call

      expect(Game.count).to eq(1)
      expect(Frame.count).to eq(1)
    end

    it 'returns a new game with a new frame' do
      result = described_class.new.call

      expect(result.state).to eq('ongoing')
      expect(result.frames).not_to be_empty
    end
  end
end
