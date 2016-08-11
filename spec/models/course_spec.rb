# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'Validation' do
    it { should validate_presence_of :title }
  end
end
