# frozen_string_literal: true

return unless defined?(Rails::Generators)

# Adds a `frozen_string_literal` comment to the top of files created by Rails
# generators.
module GeneratorFrozenStringLiteral
  RUBY_EXTENSIONS = %w[.rb .rake].freeze

  def render
    return super unless RUBY_EXTENSIONS.include? File.extname(destination)

    "# frozen_string_literal: true\n\n#{super}"
  end
end

Thor::Actions::CreateFile.prepend GeneratorFrozenStringLiteral
