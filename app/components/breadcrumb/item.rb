# frozen_string_literal: true

# Views component for rendering the sidebar menu.
class Breadcrumb::Item < ApplicationComponent
  def initialize(name:, path:)
    @name = name
    @path = path

    super
  end

  def last?
    path.nil? || current_page?(path)
  end

  private

  attr_reader :name, :path
end
