# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    bearer
    name { 'MyString' }
  end
end
