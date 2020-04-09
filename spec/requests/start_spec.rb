# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Start', type: :request do
  describe 'request' do
    it 'creates a new game' do
      post '/api/v1/games/start'

      body = JSON.parse(response.body)

      expect(response).to be_successful
      expect(body).to eq(payload)
    end

    def payload
      {
        'data' => {
          'id' => 1,
          'type' => 'game',
          'attributes' => {
            'state' => 'ongoing',
            'score' => 0
          },
          'relationships' => {
            'frames' => {
              'data' => [
                {
                  'id' => 1,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
                    }
                  }
                },
                {
                  'id' => nil,
                  'type' => 'frame',
                  'attributes' => {
                    'score' => 0
                  },
                  'relationships' => {
                    'rolls' => {
                      'data' => []
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
