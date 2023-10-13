# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { build(:user) }

  include_examples 'valid factory', :user
  include_examples 'associations', :user, %i[identities permissions roles teams]
end
