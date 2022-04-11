# frozen_string_literal: true

module Api
  module Entities
    class Bearer < Grape::Entity
      expose :id
      expose :name
    end
  end
end
