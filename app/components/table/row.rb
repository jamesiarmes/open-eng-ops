# frozen_string_literal: true

# Views component for rendering a table row.
class Table::Row < ApplicationComponent
  renders_many :columns, Table::Column
end
