# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Github::UserConfig do
  let(:services_github_user_config) { build(:services_github_user_config) }

  include_examples 'valid factory', :services_github_user_config
  include_examples 'associations', :services_github_user_config, %i[user]
end
