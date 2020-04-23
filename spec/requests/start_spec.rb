# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Start", type: :request do
  describe "request" do
    it "creates a new game" do
      post "/api/v1/games/start"

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(body).to include_json(payload)
    end

    def payload
      {
        "data" => {
          "type" => "game",
          "attributes" => {
            "state" => "ongoing",
            "score" => 0
          },
          "relationships" => {
            "frames" => {
              "data" => [
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
                    }
                  }
                },
                {
                  "type" => "frame",
                  "attributes" => {
                    "score" => 0
                  },
                  "relationships" => {
                    "rolls" => {
                      "data" => []
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
end
