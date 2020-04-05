# frozen_string_literal: true

module Forms
  module Contracts
    class Roll < Dry::Validation::Contract
      params do
        required(:id).value(:integer)
        required(:pins).value(:integer)
      end

      rule(:pins) do
        key.failure('must be a value between 0 and 10') if value.negative? || value > 10
      end
    end
  end
end
