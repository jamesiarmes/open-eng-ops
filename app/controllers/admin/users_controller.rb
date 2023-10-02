class Admin::UsersController < UserController
  before_action :set_user, only: %i[edit show update destroy]
  before_action :set_roles, only: %i[edit update destroy]
  before_action :set_breadcrumbs

  def index
    authorize :user
    @users = User.all
  end

  def show
    authorize @user
    add_breadcrumb(@user.name)
  end

  def edit
    authorize @user
    add_breadcrumb(@user.name, admin_user_path(@user))
    add_breadcrumb('Modify', edit_admin_user_path(@user))

    @user.build_address unless @user.address
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'success'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user

    if User.all.count > 1
      @user.destroy
      redirect_to admin_users_path, notice: t('.success')
    else
      redirect_to admin_user_path(@user), status: :forbidden, alert: t('.last')
    end
  end

  private

  def set_roles
    @roles = Role.all
  end

  def set_breadcrumbs
    add_breadcrumb('Users', admin_users_path)
  end
end
