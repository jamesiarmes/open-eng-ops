# frozen_string_literal: true

module NormalizedName
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_name
  end

  private

  def normalize_name
    self.name = normalize_string(human_name)
  end

  def normalize_string(str)
    str.downcase.gsub(/[^a-z0-9]/, '_')
  end
end
