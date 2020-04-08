# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_ok(json)
    render status: 200,
           json: json,
           content_type: 'application/vnd.api+json'
  end

  def render_not_found(message)
    render status: 404,
           json: { status: '404', title: 'Not Found', detail: message },
           content_type: 'application/vnd.api+json'
  end

  def render_unprocessable(message)
    render status: 422,
           json: { status: '422', title: 'Unprocessable Entity', detail: message },
           content_type: 'application/vnd.api+json'
  end
end
