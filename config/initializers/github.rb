Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
           client_options: { access_type: 'offline' },
           scope: 'read:org,write:org,read:user,project,read:packages'
end
