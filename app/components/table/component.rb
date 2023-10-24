# frozen_string_literal: true

# Views component for rendering a table.
#
# TODO: Add filters.
class Table::Component < ApplicationComponent
  renders_one :pagination, Pagination::Component
  renders_many :headers, Table::Header
  renders_many :rows, Table::Row
end
