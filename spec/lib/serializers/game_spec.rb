# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Serializers::Json::Game do
  describe '#to' do
    it 'returns the serialized payload of a game' do
      game = build_game
      serializer = described_class.new(game)

      result = serializer.to

      expect(result).to eq(build_payload(game))
    end
  end

  def build_game
    model = FactoryBot.create(
      :game,
      frames: [
        FactoryBot.create(
          :frame,
          rolls: [
            FactoryBot.create(
              :roll,
              pins: 10
            )
          ]
        )
      ]
    )

    Entities::Game.new(model)
  end

  def build_payload(game)
    game_id = game.id
    frame_id = game.frames.first.id
    roll_id = game.frames.first.rolls.first.id

    {
      data: {
        id: game_id,
        type: 'game',
        attributes: {
          state: 'ongoing',
          score: 10
        },
        relationships: {
          frames: {
            data: [
              {
                id: frame_id,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: [
                      {
                        id: roll_id,
                        type: 'roll',
                        attributes: {
                          pins: 10
                        }
                      }
                    ]
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              },
              {
                id: nil,
                type: 'frame',
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: []
                  }
                }
              }
            ]
          }
        }
      }
    }
  end
end
