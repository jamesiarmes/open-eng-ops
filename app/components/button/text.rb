# frozen_string_literal: true

# Views component for rendering a text button.
class Button::Text < Button::Component
  renders_one :icon, Icon::Component

  def initialize(path:, text:, type: :primary, data: {}, frame: nil)
    super(path:, data:, frame:)

    @text = text
    @type = type
  end

  private

  def text
    icon? ? "#{icon} #{html_escape(@text)}".html_safe : @text
  end
end
