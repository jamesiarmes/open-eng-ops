# frozen_string_literal: true

# Views component for rendering an avatar.
class Avatar::Component < ApplicationComponent
  def initialize(src:, name:, size: :sm, default: nil, disabled: false)
    @src = src
    @name = name
    @size = size
    @default = default
    @disabled = disabled

    super
  end

  def before_render
    super

    @default.disabled = @disabled if @default.present?
  end

  private

  attr_reader :name, :size, :default

  def classes
    "rounded-circle avatar-#{@size}#{@disabled ? ' disabled' : ''}"
  end

  def src
    return if @src.blank?

    @src.is_a?(String) ? @src : url_for(@src)
  end
end
