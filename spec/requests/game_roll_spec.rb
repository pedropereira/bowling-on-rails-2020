# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameRoll', type: :request do
  describe 'request' do
    it 'creates a new roll' do
      game = FactoryBot.create(:game, frames: [FactoryBot.create(:frame)])
      post "/games/#{game.id}/roll", params: { pins: '10' }

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(body).to eq(
        'data' => {
          'id' => game.id.to_s,
          'type' => 'game',
          'attributes' => {
            'state' => 'ongoing'
          },
          'relationships' => {
            'frames' => {
              'data' => [
                {
                  'id' => '1',
                  'type' => 'frame'
                },
                {
                  'id' => '2',
                  'type' => 'frame'
                }
              ]
            }
          }
        }
      )
    end

    it 'fails with 422 if pins parameter is missing' do
      game = FactoryBot.create(:game, frames: [FactoryBot.create(:frame)])
      post "/games/#{game.id}/roll", params: {}

      body = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(body).to eq(
        'detail' => "Pins can't be blank, Pins is not a number",
        'status' => '422',
        'title' => 'Unprocessable Entity'
      )
    end

    it 'fails with 422 if game is already finished' do
      game = FactoryBot.create(:game, state: 'finished')
      post "/games/#{game.id}/roll", params: { pins: '10' }

      body = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(body).to eq(
        'detail' => 'Game already finished',
        'status' => '422',
        'title' => 'Unprocessable Entity'
      )
    end

    it 'fails with 404 if game does not exist' do
      post '/games/1024/roll', params: { pins: '10' }

      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(body).to eq(
        'detail' => "Couldn't find Game with 'id'=1024",
        'status' => '404',
        'title' => 'Not Found'
      )
    end
  end
end