# frozen_string_literal: true

class JsonbSerializers
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    hash = JSON.parse(hash) if hash.instance_of?(String)
    (hash || {}).with_indifferent_access
  end
end
