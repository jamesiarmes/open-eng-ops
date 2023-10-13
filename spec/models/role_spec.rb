# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role do
  let(:role) { build(:role) }

  include_examples 'valid factory', :role
  include_examples 'associations', :role, %i[permissions users]
end
