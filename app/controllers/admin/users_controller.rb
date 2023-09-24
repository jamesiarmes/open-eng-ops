class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]
  before_action :set_roles, only: %i[edit update]
  before_action :set_breadcrumbs

  def index
    @users = User.all
    # authorize current_user
  end

  def show
    add_breadcrumb(@user.name)
  end

  def edit
    add_breadcrumb(@user.name, admin_user_path(@user))
    add_breadcrumb('Modify', edit_admin_user_path(@user))

    @user.build_address unless @user.address
  end

  def update
    # authorize! :update, :data_sets
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'success'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_roles
    @roles = Role.all
  end

  def set_user
    @user = User.find(params['id'])
  end

  def user_params
    params.require(:user).permit(
      :avatar, :name, :email, :phone, :pronouns, :roles, address_attributes: [
        :administrative_area, :country, :locality, :postal_code, :street1, :street2
      ]
    )
  end

  def set_breadcrumbs
    add_breadcrumb('Users', admin_users_path)
  end
end
