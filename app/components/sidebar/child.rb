# frozen_string_literal: true

# Views component for rendering child menu items in the sidebar.
class Sidebar::Child < Sidebar::Item
  renders_many :items, Sidebar::Child

  private

  def classes
    'text-reset'
  end
end
