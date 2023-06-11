# frozen_string_literal: true

class Service < ApplicationRecord
  serialize :config, ::JsonbSerializers

  def service_type
    self.class.name.split('::').last
  end
end

