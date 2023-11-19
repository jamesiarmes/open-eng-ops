# frozen_string_literal: true

# Views component for rendering an icon.
class Icon::Component < ApplicationComponent
  TYPE_CLASSES = {
    brand: 'fab',
    regular: 'far',
    solid: 'fas',
  }.freeze

  attr_writer :disabled

  def initialize(icon:, type: :solid, title: '', classes: '', disabled: false)
    @icon = icon
    @type = type
    @title = title
    @classes = classes
    @disabled = disabled

    super
  end

  private

  attr_reader :title

  def classes
    "#{type_class} fa-#{@icon} #{@classes}#{@disabled ? ' disabled' : ''}"
  end

  def type_class
    TYPE_CLASSES[@type]
  end
end
