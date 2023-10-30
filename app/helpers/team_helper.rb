module TeamHelper
  def default_team_icon(size: :sm)
    @default_team_icon ||= Icon::Component.new(
      icon: 'user-group',
      classes: "rounded-circle default-avatar-#{size}"
    )
  end
end
