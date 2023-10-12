require 'rails_helper'

RSpec.describe Team do
  let(:team) { build(:team) }

  include_examples 'valid factory', :team
end
