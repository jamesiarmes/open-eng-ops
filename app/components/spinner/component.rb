# frozen_string_literal: true

# Views component for rendering a loading spinner.
class Spinner::Component < ApplicationComponent
  def initialize(text: 'Loading…')
    @text = text

    super
  end

  private

  attr_reader :text
end
