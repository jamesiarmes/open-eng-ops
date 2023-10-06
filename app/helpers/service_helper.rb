module ServiceHelper
  def service_factory(params)
    return Service.new(params) if params[:type].blank?

    params[:type].constantize.new(params)
  end

  def service_path(service, options = {})
    send("#{service.route_helper_prefix}_path", service, options)
  end

  def service_type_options
    # Make sure all of our models have been loaded first.
    Rails.application.eager_load!
    Service.descendants.map do |service_type|
      [service_type.service_type, service_type]
    end
  end

  def enabled_service_types
    Service.order(:type).distinct.pluck(:type).map(&:constantize)
  end
end
