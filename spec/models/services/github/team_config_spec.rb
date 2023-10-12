# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Github::TeamConfig do
  let(:services_github_team_config) { build(:services_github_team_config) }

  include_examples 'valid factory', :services_github_team_config
end
