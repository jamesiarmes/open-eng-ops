class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit show update]

  def show
    authorize @user
  end

  def edit
    authorize @user
    add_breadcrumb(@user.name, user_path(@user))
    add_breadcrumb('Modify', edit_user_path(@user))

    @user.build_address unless @user.address
    @user.build_services_github_user_config unless @user.services_github_user_config
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'success'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params['id'])
  end

  def user_params
    params.require(:user).permit(
      :id, :avatar, :name, :email, :phone, :pronouns, :password, role_ids: [],
      address_attributes: [
        :administrative_area, :country, :locality, :postal_code, :street1,
        :street2
      ],
      services_github_user_config_attributes: [:username]
    )
  end
end
