# frozen_string_literal: true

# Views component for rendering a button.
#
# This component is not meant to be used on its own. Use of the the child
# components instead.
class Button::Component < ApplicationComponent
  def initialize(path:, data: {}, frame: nil)
    super

    @path = path
    @data = data
    @frame = frame
  end

  def before_render
    super

    @data[:turbo_frame] = @frame if @frame.present?
  end

  private

  attr_reader :path, :data

  def classes
    "btn btn-#{@type} mx-1"
  end

  # Return nothing by default.
  def text; end
end
