# frozen_string_literal: true

module Forms
  class Roll
    attr_reader :contract
    attr_reader :params
    attr_reader :validation

    def initialize(params = {})
      @params = params
      @contract = Forms::Contracts::Roll.new
      @validation = @contract.call(@params)
      @errors = Forms::Errors.new(@validation.errors.to_h)
    end

    def call
      if @errors.empty?
        create_roll(id: params[:id], pins: params[:pins])
      else
        false
      end
    end

    def errors
      @errors.to_s
    end

    private

    def create_roll(id:, pins:)
      game = game_repository.find(id)
      game_decorator = Entities::Game.new(game)
      result = game_decorator.roll(pins.to_i)

      if result
        game
      else
        @errors.add(game: 'is already finished')
        false
      end
    end

    def game_repository
      @game_repository ||= GameRepository.new
    end
  end
end
