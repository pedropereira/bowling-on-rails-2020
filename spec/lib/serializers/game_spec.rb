# frozen_string_literal: true

require "rails_helper"

RSpec.describe Serializers::Json::Game do
  describe "#to" do
    it "returns the serialized payload of a game" do
      game = build_game
      serializer = described_class.new(game)

      result = serializer.to

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
