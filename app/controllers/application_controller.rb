# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_200(json)
    render status: 200,
           json: json,
           content_type: 'application/vnd.api+json'
  end

  def render_404(message)
    render status: 404,
           json: { status: '404', title: 'Not Found', detail: message },
           content_type: 'application/vnd.api+json'
  end

  def render_422(message)
    render status: 422,
           json: { status: '422', title: 'Unprocessable Entity', detail: message },
           content_type: 'application/vnd.api+json'
  end
end
