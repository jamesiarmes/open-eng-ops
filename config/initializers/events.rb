# frozen_string_literal: true

# TODO: Determine what other events we need to subscribe to.
ActiveSupport::Notifications.subscribe(/team/) do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  method_name = event.name.tr('.', '_')
  Team.reflect_on_all_associations.each do |assoc|
    next unless /^services_/.match?(assoc.name)

    event.payload[:team].send(assoc.name).each do |relation|
      break unless relation.respond_to?(method_name)

      relation.send(method_name, event.payload[:user])
    end
  end
end
