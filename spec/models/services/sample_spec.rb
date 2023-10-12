# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Sample do
  let(:services_sample) { build(:services_sample) }

  include_examples 'valid factory', :services_sample
end
