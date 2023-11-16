# frozen_string_literal: true

class Card::Component < ApplicationComponent
  renders_one :header, Card::Header
  renders_one :footer, Card::Footer

  def initialize(body_classes: '')
    super

    @body_classes = body_classes
  end

  private

  def body_classes
    "#{body_padding} #{@body_classes}"
  end

  def body_padding
    padding = []
    padding << 'pt-0' if header?
    padding << 'pb-0' if footer?

    padding.join(' ')
  end
end
