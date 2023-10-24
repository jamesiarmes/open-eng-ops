module UserHelper
  def default_user_icon(size: :sm)
    @default_user_icon ||= Icon::Component.new(
      icon: 'circle-user',
      classes: "rounded-circle avatar-#{size}"
    )
  end
end
