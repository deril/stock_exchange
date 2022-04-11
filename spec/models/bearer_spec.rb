# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bearer, type: :model do
  describe 'validations' do
    subject(:instance) { build(:bearer) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
