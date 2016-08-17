# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Storage, type: :model do
  context 'Validation' do
    it { should validate_presence_of :source }
  end
end
