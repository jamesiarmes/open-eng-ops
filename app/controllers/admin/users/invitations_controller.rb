class Admin::Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!, except: [:new]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_roles, only: %i[new]

  def new
    authorize :user

    super
  end

  def create
    authorize :user

    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      render turbo_stream: turbo_visit(after_create_path_for(resource), frame: '_top')
    else
      respond_with(resource)
    end
  end

  private

  def after_create_path_for(_resource)
    admin_users_path
  end

  def set_roles
    @roles = Role.all
  end

  def after_accept_path_for(resource)
    edit_user_path(resource)
  end

  def after_invite_path_for(_resource)
    { turbo_stream: turbo_visit(admin_users_path, frame: '_top') }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite,
                                      keys: [:email, :name, :pronouns, {role_ids: []}])
    devise_parameter_sanitizer.permit(:accept_invitation,
                                      keys: [:email, :name, :pronouns, {role_ids: []}])
  end

  def turbo_visit(url, frame: nil, action: nil)
    options = {frame: frame, action: action}.compact
    turbo_stream.append_all("head") do
      helpers.javascript_tag(<<~SCRIPT.strip, nonce: true, data: {turbo_cache: false})
      window.Turbo.visit("#{helpers.escape_javascript(url)}", #{options.to_json})
      document.currentScript.remove()
    SCRIPT
    end
  end
end
