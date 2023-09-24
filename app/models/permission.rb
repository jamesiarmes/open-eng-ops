class Permission < ApplicationRecord
  has_and_belongs_to_many :roles


  def self.grouped_select
    order(:controller, :name).each_with_object({}) do |p, h|
      h[p.controller] ||= []
      h[p.controller] << [p.name, p.id]
    end
  end
end
