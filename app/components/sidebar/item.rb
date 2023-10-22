# frozen_string_literal: true

# Views component for rendering menu items in the sidebar.
class Sidebar::Item < ApplicationComponent
  renders_many :items, Sidebar::Child

  attr_reader :title

  def initialize(path:, icon:, title:)
    @path = path
    @icon = icon
    @title = title

    super
  end

  def active?
    current_page?(path) || items.any?(&:active?)
  end

  def parent?
    items.present?
  end

  private

  attr_reader :icon, :path

  def classes
    "list-group-item list-group-item-action py-2 ripple#{' active' if active? && !parent?}"
  end

  def content_id
    path.sub(/^#/, '')
  end

  def link_attributes
    parent_attributes.deep_merge(
      class: classes,
      aria: { current: active? }
    )
  end

  def parent_attributes
    return {} unless parent?

    {
      aria: {
        expanded: active?,
        controls: content_id
      },
      data: {
        mdb_toggle: 'collapse'
      }
    }
  end
end
