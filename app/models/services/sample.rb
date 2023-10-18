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

  def service_avatar(size: :sm)
    "<i class=\"fa-solid fa-vial fa-fw default-avatar-#{size}\" " \
      "title=\"#{service_type}\"></i>".html_safe
  end
end
