module PlayStationNetwork
  class User
    attr_accessor :options

    INVALID_IDENTITY_TYPE ||="'identity' parameter needs to be a String"
    INVALID_NPCOMMID_TYPE ||= "'npcommid' parameter needs to be a String"

    def initialize(identity)
      PlayStationNetwork::API.handle_response do
        raise ArgumentError, INVALID_IDENTITY_TYPE unless identity.is_a?(String)
        
        @options = PlayStationNetwork::API.request.merge(user_id: identity)
      end
    end

    def profile
      PlayStationNetwork::API.handle_response do
        PlayStationNetwork::API.parse_response('/psnGetUser', body: options)
      end
    end

    def games
      PlayStationNetwork::API.handle_response do
        PlayStationNetwork::API.parse_response('/psnGetUserGames', body: options)
      end
    end
    
    def trophies(npcommid)
      PlayStationNetwork::API.handle_response do
        raise INVALID_NPCOMMID_TYPE unless npcommid.is_a?(String)

        @options = options.merge(npcommid: npcommid)
        PlayStationNetwork::API.parse_response('/psnGetUserTrophies', body: options)
      end
    end
  end
end