# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Permission do
  let(:permission) { build(:permission) }

  include_examples 'valid factory', :permission
end
