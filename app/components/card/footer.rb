# frozen_string_literal: true

# Views component for rendering a card footer.
class Card::Footer < ApplicationComponent
  renders_many :buttons, types: {
    icon: Button::Icon,
    text: Button::Text
  }
end
