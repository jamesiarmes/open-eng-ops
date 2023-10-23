# frozen_string_literal: true

# Views component for rendering an icon.
class Icon::Component < ApplicationComponent
  TYPE_CLASSES = {
    brand: 'fab',
    regular: 'far',
    solid: 'fas',
  }.freeze

  def initialize(icon:, type: :solid, title: '', classes: '')
    @icon = icon
    @type = type
    @title = title
    @classes = classes

    super
  end

  private

  attr_reader :title

  def classes
    "#{type_class} fa-#{@icon} #{@classes}"
  end

  def type_class
    TYPE_CLASSES[@type]
  end
end
