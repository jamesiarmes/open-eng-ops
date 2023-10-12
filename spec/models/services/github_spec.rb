# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Github, type: :model do
  let(:services_github) { build(:services_github) }

  include_examples 'valid factory', :services_github
end
