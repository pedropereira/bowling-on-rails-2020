# frozen_string_literal: true

module Serializers
  module Db
    class Game
      def from(model)
        {
          created_at: model.created_at,
          id: model.id,
          state: model.state,
          updated_at: model.updated_at
        }
      end
    end
  end
end
