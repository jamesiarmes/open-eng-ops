# frozen_string_literal: true

# Views component for rendering menu items in the sidebar.
class Sidebar::ItemComponent < ApplicationComponent
  renders_many :items, Sidebar::ChildItemComponent

  def initialize(path:, icon:, title:)
    @path = path
    @icon = icon
    @title = title

    super
  end

  def active?
    current_page?(path)
  end

  private

  attr_reader :icon, :path, :title

  def classes
    "list-group-item list-group-item-action py-2 ripple#{' active' if active?}"
  end

  def link_attributes
    attributes = {
      class: classes,
      aria: { current: active? }
    }

    return attributes if items.blank?

    {
      aria: {
        expanded: true,
        controls: path
      },
      data: {
        mdb_toggle: 'collapse'
      }
    }.merge(attributes)
  end
end
