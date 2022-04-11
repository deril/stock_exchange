# frozen_string_literal: true

module Api
  module Entities
    class Stock < Grape::Entity
      expose :id
      expose :name
      expose :bearer, using: Api::Entities::Bearer
    end
  end
end
