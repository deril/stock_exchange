# frozen_string_literal: true

module Api
  class Root < Grape::API
    default_format :json
    format :json

    helpers Api::Helpers::ErrorHandlers

    rescue_from ActiveRecord::RecordNotFound, with: :error_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :error_record_invalid
    rescue_from Grape::Exceptions::ValidationErrors, with: :error_record_invalid

    mount Stocks
  end
end
