# frozen_string_literal: true

# Views component for rendering a card header.
class Card::Header < ApplicationComponent
  renders_one :icon, Icon::Component
  renders_many :buttons, types: {
    icon: Button::Icon,
    text: Button::Text
  }

  def initialize(title: nil, subtitle: nil)
    super

    @title = title
    @subtitle = subtitle
  end

  private

  attr_reader :title, :subtitle
end
