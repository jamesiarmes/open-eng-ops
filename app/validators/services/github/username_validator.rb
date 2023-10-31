# frozen_string_literal: true

# Validator for Github usernames.
class Services::Github::UsernameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    service(record).user(value)
  rescue Octokit::NotFound
    record.errors.add(attribute, 'is not a valid GitHub username')
  end

  private

  def service(record)
    record.respond_to?(:service) ? record.service : Services::Github.first
  end
end
