# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Teacher, type: :model do
  context 'Validation' do
    it { should validate_presence_of :firstname }
    it { should validate_presence_of :lastname }
  end
end
