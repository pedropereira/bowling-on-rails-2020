# frozen_string_literal: true

module Serializers
  module Json
    class Frame
      attr_reader :frame

      def initialize(frame)
        @frame = frame
      end

      # rubocop:disable Metrics/MethodLength
      def to
        {
          "id": frame.id,
          "type": 'frame',
          "attributes": {
            "score": Services::CalculateScore.new.for_frame(frame)
          },
          "relationships": {
            "rolls": {
              "data": frame.rolls.map { |roll| Serializers::Json::Roll.new(roll).to }
            }
          }
        }
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
