# frozen_string_literal: true

module Api
  module Helpers
    module ErrorHandlers
      extend Grape::API::Helpers

      def error_record_not_found(error)
        error!({ error: error.message }, 404)
      end

      def error_record_invalid(error)
        error!({ error: error.message.split(', ') }, 422)
      end
    end
  end
end
