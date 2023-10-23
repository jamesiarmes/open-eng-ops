# frozen_string_literal: true

# Views component for rendering a table header column.
class Table::Header < ApplicationComponent
  renders_one :icon, Icon::Component

  def initialize(title: '', sort: false, direction: 'asc', align: 'left')
    @title = title
    @sort = sort
    @direction = direction
    @align = align

    super
  end

  private

  attr_reader :title

  def classes
    "text-#{@align}"
  end

  def link?
    @sort.present?
  end

  def link_params
    { sort: @sort, direction: @direction }
  end
end
