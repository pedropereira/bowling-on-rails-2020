# frozen_string_literal: true

module Entities
  class Roll < Base
    delegate :created_at,
             :frame_id,
             :pins,
             :updated_at,
             to: :model
  end
end
