# frozen_string_literal: true

# Views component for rendering the sidebar menu.
class Sidebar::Component < ApplicationComponent
  renders_many :items, Sidebar::Item

  def initialize(current_user:)
    @current_user = current_user

    super
  end

  private

  attr_reader :current_user
end
