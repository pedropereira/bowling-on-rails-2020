# frozen_string_literal: true

FactoryBot.define do
  factory :roll do
    pins { 1 }

    association :frame
  end
end
