# frozen_string_literal: true

module Serializers
  module Db
    class Roll
      def from(model)
        {
          created_at: model.created_at,
          frame_id: model.frame_id,
          id: model.id,
          pins: model.pins,
          updated_at: model.updated_at
        }
      end
    end
  end
end
