# frozen_string_literal: true

class Bearer < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
