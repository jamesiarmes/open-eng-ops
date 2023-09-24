class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user?
        scope.all
      end
    end
  end

  def index?
    user.has_role?(:admin) or has_permissions('view_users')
  end
end
