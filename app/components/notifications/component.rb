# frozen_string_literal: true

# Views component for rendering notifications for a record.
class Notifications::Component < ApplicationComponent
  def initialize(record:, id: 'notifications', state: :all)
    @record = record
    @state = state

    super
  end

  private

  def notifications
    @record.notifications.send(@state).newest_first.each do |notification|
      yield notification.to_notification if block_given?
    end
  end
end
