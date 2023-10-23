# frozen_string_literal: true

# Views component for rendering pagination.
class Pagination::Component < ApplicationComponent
  renders_one :first, Pagination::Page
  renders_one :previous, Pagination::Page
  renders_one :next, Pagination::Page
  renders_one :last, Pagination::Page

  attr_reader :frame

  def initialize(label:, frame: nil)
    @label = label
    @frame = frame

    super
  end

  def before_render
    super

    return if frame.blank?

    first.with_frame(frame) if first?
    previous.with_frame(frame) if previous?
    self.next.with_frame(frame) if next?
    last.with_frame(frame) if last?
  end

  private

  attr_reader :label
end
