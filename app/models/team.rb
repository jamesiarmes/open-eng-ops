class Team < ApplicationRecord
  include NormalizedName

  has_and_belongs_to_many :users, join_table: :team_members,
                          after_add: :member_added, after_remove: :member_removed
  has_one_attached :logo
  has_many :services_github_team_to_teams, class_name: 'Services::Github::TeamToTeam',
                                           dependent: :destroy

  validates :human_name, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { message: 'Team already exists with his name.' }

  private

  def member_added(user)
    ActiveSupport::Notifications.instrument 'team.member_added', team: self, user: user
  end

  def member_removed(user)
    ActiveSupport::Notifications.instrument 'team.member_removed', team: self, user: user
  end
end
