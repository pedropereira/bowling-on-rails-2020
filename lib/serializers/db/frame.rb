# frozen_string_literal: true

module Serializers
  module Db
    class Frame
      def from(model)
        {
          created_at: model.created_at,
          id: model.id,
          game_id: model.game_id,
          kind: model.kind,
          updated_at: model.updated_at
        }
      end
    end
  end
end
