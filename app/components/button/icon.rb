# frozen_string_literal: true

# Views component for rendering an icon only button.
class Button::Icon < Button::Component
  def initialize(path:, icon:, data: {}, frame: nil)
    super(path:, data:, frame:)

    @icon = icon
  end

  private

  def classes; end

  def text
    render(@icon)
  end
end
