module PlayStationNetwork
  module API
    include HTTParty

    base_uri ''

    def self.config
      @@config
    end

    def self.key(api_key)
      @@config = {
        api_key: api_key,
        format: 'json'
      }
    end
  end
end
