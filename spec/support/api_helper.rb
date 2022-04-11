# frozen_string_literal: true

module ApiHelper
  def json_response
    JSON.parse(response.body)
  end
end
