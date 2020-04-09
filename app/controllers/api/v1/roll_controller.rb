# frozen_string_literal: true

module API
  module V1
    class RollController < ApplicationController
      def call
        form = Forms::Roll.new(permitted_params)
        result = form.call

        if result
          render_ok(result)
        else
          render_unprocessable(form.errors)
        end
      end

      private

      def permitted_params
        params.permit(:id, :pins).to_h
      end
    end
  end
end
