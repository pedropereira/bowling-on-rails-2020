# frozen_string_literal: true

FactoryBot.define do
  factory :frame do
    kind { "regular" }

    association :game
  end
end
