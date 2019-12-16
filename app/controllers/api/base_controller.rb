# frozen_string_literal: true

class Api::BaseController < ApplicationController
  around_action :handle_errors

  def handle_errors
    yield
  rescue ActiveRecord::RecordNotFound => e
    render_api_error(e.message, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    render jsonapi_errors: e.record.errors, status: :unprocessable_entity
  end

  def render_api_error(messages, code)
    data = { errors: { code: code, details: Array.wrap(messages) } }
    render json: data, status: code
  end
end
