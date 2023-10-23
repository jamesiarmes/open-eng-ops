# frozen_string_literal: true

# Views component for rendering a page item for pagination..
class Pagination::Page < ApplicationComponent
  renders_one :frame, ->(frame) { @frame = frame }

  def initialize(title:, path:, page:, disabled: false)
    @title = title.to_s
    @path = path
    @page = page
    @disabled = disabled

    super
  end

  private

  attr_reader :title

  def frame
    @frame
  end

  def disabled?
    @disabled || current? || (@page.instance_of?(Numeric) && @page < 1)
  end

  def current?
    (params[:page] || 1).to_i == (@page || 1)
  end

  def path
    @path.merge(page: @page)
  end
end
