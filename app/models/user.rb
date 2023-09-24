class User < ApplicationRecord
  phonofy :phone
  rolify

  has_many :permissions, through: :roles
  belongs_to :address
  has_one_attached :avatar

  accepts_nested_attributes_for :address, update_only: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email, presence: true
  validates :name, presence: true
  validates :pronouns, presence: true

  before_validation :assign_user_default_role

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
    admin_role = Role.find_or_create_by(name: 'admin') do |role|
      role.permissions = Permission.all
    end

    # TODO: Invitation validation.
    # add_role(:admin) if admin_role.persisted? && !invited_by.present?
    add_role(:admin) if admin_role.persisted?
  end
end
