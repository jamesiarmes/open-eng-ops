# frozen_string_literal: true

# Views component for rendering a modal dialog.
class Modal::Component < ApplicationComponent
  renders_one :icon, Icon::Component
  renders_one :footer

  def initialize(title: nil, frame: 'modal')
    @title = title
    @frame = frame

    super
  end

  private

  attr_reader :title, :frame
end
