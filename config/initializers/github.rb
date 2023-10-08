Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
           client_options: { access_type: 'offline' },
           scope: 'admin:org,project,read:packages,read:user'
end
