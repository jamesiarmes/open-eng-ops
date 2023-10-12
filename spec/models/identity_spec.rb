# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identity do
  let(:identity) { build(:identity) }

  include_examples 'valid factory', :identity
end
