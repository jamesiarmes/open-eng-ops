module ServiceHelper
  def service_path(service, options = {})
    send("#{service.route_helper_prefix}_path", service, options)
  end
end
