# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    state { Entities::Game::ONGOING }
  end
end
