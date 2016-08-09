# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PublicUser, type: :model do
  context 'Validation' do
    it { should validate_presence_of :email }
    it { should validate_acceptance_of :data_privacy }
    it { should validate_acceptance_of :terms_and_conditions }
  end
end
