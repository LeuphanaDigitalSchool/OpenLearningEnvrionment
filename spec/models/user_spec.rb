# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validation' do
    it { should validate_presence_of :email }
  end
end
