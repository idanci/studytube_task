# frozen_string_literal: true

class Api::BaseController < ApplicationController
  around_action :handle_errors

  def handle_errors
    yield
  rescue ActiveRecord::RecordNotFound => e
    render_record_not_found(e.message, :not_found)
  rescue ActiveRecord::RecordInvalid => e
    render jsonapi_errors: e.record.errors, status: :unprocessable_entity
  end

  def render_record_not_found(message, code)
    data = { errors: [{ code: code, detail: message }] }
    render json: data, status: code
  end
end
