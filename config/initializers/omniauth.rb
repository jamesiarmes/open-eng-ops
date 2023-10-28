# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
           client_options: { access_type: 'offline' },
           scope: 'admin:org,project,read:packages,read:user'

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
           scope: %w[profile admin.directory.group admin.directory.orgunit
                     admin.directory.user admin.directory.rolemanagement
                     admin.directory.userschema admin.directory.customer
                     admin.directory.domain
                     cloud-identity.groups cloud-platform]
end
