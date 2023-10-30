class User < ApplicationRecord
  phonofy :phone
  rolify

  has_many :identities
  has_many :permissions, through: :roles
  has_one :services_github_user_config, class_name: 'Services::Github::UserConfig',
                                        dependent: :destroy
  belongs_to :address, optional: true, dependent: :destroy
  has_one_attached :avatar
  has_and_belongs_to_many :teams, join_table: :team_members

  accepts_nested_attributes_for :address, update_only: true
  accepts_nested_attributes_for :services_github_user_config, update_only: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email, presence: true
  validates :name, presence: true

  before_validation :assign_user_default_role, on: [:create]

  def formatted_phone
    parsed_phone = Phonelib.parse(phone)
    return phone if parsed_phone.invalid?

    formatted =
      if parsed_phone.country_code == "1" # NANP
        parsed_phone.full_national # (415) 555-2671;123
      else
        parsed_phone.full_international # +44 20 7183 8750
      end
    formatted.gsub!(";", " x") # (415) 555-2671 x123
    formatted
  end

  private

  def assign_user_default_role
    return unless roles.empty?

    self.role_ids = Role.select(:id).where(default: true).map(&:id)
  end
end
