# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::GetScore do
  describe "#call" do
    it "returns game score payload" do
      game = build_game

      result = described_class.new.call(game.id)

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
    attributes = Serializers::Db::Game.new.from(model)

    Entities::Game.new(attributes)
  end

  def build_payload(game)
    game_id = game.id
    frame_id = game.frames.first.id
    roll_id = game.frames.first.rolls.first.id

    {
      data: {
        id: game_id,
        type: "game",
        attributes: {
          state: "ongoing",
          score: 10
        },
        relationships: {
          frames: {
            data: [
              {
                id: frame_id,
                type: "frame",
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: [
                      {
                        id: roll_id,
                        type: "roll",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
                type: "frame",
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
