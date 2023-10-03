# frozen_string_literal: true

# TODO: Determine what other events we need to subscribe to.
# TODO: Decouple service specific logic.
ActiveSupport::Notifications.subscribe(/team/) do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  next unless ['team.member_added', 'team.member_removed'].include?(event.name)

  config = event.payload[:user].services_github_user_config
  next unless config&.username

  relations = event.payload[:team].services_github_team_to_teams
  next unless relations.count.positive?

  relations.each do |relation|
    job = event.name == 'team.member_added' ? 'AddUserToTeamJob' : 'RemoveUserFromTeamJob'
    Object.const_get("Services::Github::#{job}").perform_later config:, relation:
  end
end
