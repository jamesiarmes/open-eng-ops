# frozen_string_literal: true

# Views component for rendering a breadcrumb trail.
class Breadcrumb::Component < ApplicationComponent
  renders_many :items, Breadcrumb::Item
end
