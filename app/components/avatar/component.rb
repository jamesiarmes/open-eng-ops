# frozen_string_literal: true

# Views component for rendering an avatar.
class Avatar::Component < ApplicationComponent
  def initialize(src:, name:, size: :sm, default: nil)
    @src = src
    @name = name
    @size = size
    @default = default

    super
  end

  private

  attr_reader :name, :size, :default

  def src
    return if @src.blank?

    @src.is_a?(String) ? @src : url_for(@src)
  end
end
