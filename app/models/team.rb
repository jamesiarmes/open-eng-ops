class Team < ApplicationRecord
  include NormalizedName

  has_and_belongs_to_many :users, join_table: 'team_members',
                                  after_add: :member_added,
                                  after_remove: :member_removed
  has_one_attached :logo
  has_many :services_github_team_configs, class_name: 'Services::Github::TeamConfig',
                                          dependent: :destroy
  has_many :services_google_workspace_team_group_configs, class_name: 'Services::GoogleWorkspace::TeamGroupConfig',
                                                          dependent: :destroy

  scope :with_github_team, lambda { |team|
    joins(:services_github_team_configs)
      .merge(Services::Github::TeamConfig.where(github_team_id: team))
      .uniq
  }
  scope :with_google_group, lambda { |group|
    joins(:services_google_workspace_team_group_configs)
      .merge(Services::GoogleWorkspace::TeamGroupConfig.where(group_id: group))
      .uniq
  }

  validates :human_name, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { message: 'Team already exists with his name.' }

  private

  def member_added(user)
    UserTeamMembershipNotification.with(state: :added, team: self).deliver_later(user)
    ActiveSupport::Notifications.instrument 'team.member_added', team: self, user: user
  end

  def member_removed(user)
    UserTeamMembershipNotification.with(state: :removed, team: self).deliver_later(user)
    ActiveSupport::Notifications.instrument 'team.member_removed', team: self, user: user
  end
end
