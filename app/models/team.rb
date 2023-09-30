class Team < ApplicationRecord
  include NormalizedName

  has_and_belongs_to_many :users, join_table: :team_members
  has_one_attached :logo
  has_many :services_github_team_to_teams, class_name: 'Services::Github::TeamToTeam',
                                           dependent: :destroy

  validates :human_name, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { message: 'Team already exists with his name.' }
end