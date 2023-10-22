class Services::Sample < Service
  def self.service_type
    'Sample'
  end

  def self.partial_path
    'sample'
  end

  def route_helper_prefix
    'services_sample'
  end

  def service_avatar_classes
    'fas fa-vial'
  end
end
