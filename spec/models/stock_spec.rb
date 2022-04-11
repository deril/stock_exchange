# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:bearer) }
  end

  describe 'validations' do
    subject(:instance) { build(:stock) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
