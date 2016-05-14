module PlayStationNetwork
  module API
    include HTTParty

    base_uri ''

    def self.config
      {
        body: {
          api_key: '',
          api_secret: '',
          response_type: 'json'
        }
      }
    end
  end
end
