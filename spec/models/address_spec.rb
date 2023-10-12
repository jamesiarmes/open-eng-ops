# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  let(:address) { build(:address) }

  include_examples 'valid factory', :address
end
