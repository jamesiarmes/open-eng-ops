# frozen_string_literal: true

class Card::Header < ApplicationComponent
  renders_one :icon, Icon::Component

  def initialize(title: nil, subtitle: nil)
    super

    @title = title
    @subtitle = subtitle
  end

  private

  attr_reader :title, :subtitle
end
