# frozen_string_literal: true

module ApplicationHelper
  def auth_path(provider, params = {})
    "/auth/#{provider}?#{params.to_query}"
  end
end
