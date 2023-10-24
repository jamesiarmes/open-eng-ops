# frozen_string_literal: true

module Services::GithubHelper
  def default_github_icon(size: :sm)
    @default_github_icon ||= Icon::Component.new(
      type: :brand,
      icon: 'github',
      classes: "rounded-circle avatar-#{size}"
    )
  end
end
