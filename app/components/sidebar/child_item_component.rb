# frozen_string_literal: true

# Views component for rendering child menu items in the sidebar.
class Sidebar::ChildItemComponent < Sidebar::ItemComponent
  renders_many :items, Sidebar::ChildItemComponent

  private

  def classes
    'text-reset'
  end
end
