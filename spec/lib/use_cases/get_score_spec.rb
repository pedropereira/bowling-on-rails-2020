# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::GetScore do
  describe "#call" do
    it "returns game score payload" do
      game = build_game

      result = described_class.new.call(game.id)

      expect(result).to include_json(build_payload)
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

  def build_payload
    {
      data: {
        type: "game",
        attributes: {
          state: "ongoing",
          score: 10
        },
        relationships: {
          frames: {
            data: [
              {
                type: "frame",
                attributes: {
                  score: 0
                },
                relationships: {
                  rolls: {
                    data: [
                      {
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
