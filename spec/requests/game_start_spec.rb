# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameStart', type: :request do
  describe 'request' do
    it 'creates a new game' do
      post '/games/start'

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(body).to eq(
        'data' => {
          'id' => '1',
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
                }
              ]
            }
          }
        }
      )
    end
  end
end
