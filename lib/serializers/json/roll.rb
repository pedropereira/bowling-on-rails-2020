# frozen_string_literal: true

module Serializers
  module Json
    class Roll
      attr_reader :roll

      def initialize(roll)
        @roll = roll
      end

      def to
        {
          "id": roll.id,
          "type": 'roll',
          "attributes": {
            "pins": roll.pins
          }
        }
      end
    end
  end
end
