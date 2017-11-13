module PlayStationNetwork
  class Game
    attr_accessor :options

    GAMES_PARAMETERS_TYPES ||= ['all', 'ps4', 'ps3', 'psvita']

    INVALID_NPCOMMID_TYPE ||="'npcommid' parameter needs to be a String"
    INVALID_PLATFORM_TYPE ||= "'platform' parameter needs to be a String and be one of #{ GAMES_PARAMETERS_TYPES.join(', ') }"
    INVALID_PLATFORM_PARAM ||= "'platform' needs to be one of #{ GAMES_PARAMETERS_TYPES.join(', ') }"
    INVALID_POPULAR_TYPE ||= "'popular' parameter needs to be a Boolean"
    
    def initialize(npcommid = "")
      PlayStationNetwork::API.handle_response do
        raise INVALID_NPCOMMID_TYPE unless npcommid.is_a?(String)

        @options = PlayStationNetwork::API.request

        unless npcommid.blank?
          @options = @options.merge(npcommid: npcommid)
        end
      end
    end

    def details
      PlayStationNetwork::API.handle_response do
        PlayStationNetwork::API.parse_response('/psnGetGame', options)
      end
    end

    def trophies      
      PlayStationNetwork::API.handle_response do
        PlayStationNetwork::API.parse_response('/psnGetTrophies', options)
      end
    end

    def all(platform: 'all', popular: false)
      PlayStationNetwork::API.handle_response do
        raise INVALID_PLATFORM_TYPE unless platform.is_a?(String)
        raise INVALID_PLATFORM_PARAM unless GAMES_PARAMETERS_TYPES.include?(platform)
        raise INVALID_POPULAR_TYPE unless popular.is_a?(FalseClass) || popular.is_a?(TrueClass)

        if popular
          url = '/psnPopularThisWeek'
        else
          @options = options.merge(platform: platform)
          url = '/psnListGames'
        end

        request = PlayStationNetwork::API.post(url, body: options)

        if request.success?
          begin
            parse_xml(request)['psn_api']
          rescue
            raise "There was a problem parsing the XML response"
          end
        else
          raise request.response
        end
      end
    end
  
  private

    def parse_xml(response)
      xml_parsed = response
        .gsub('<?xml version=\"1.0\"?>', '')
        .gsub('<\/', '</')
        .tr('"', '')

      return Hash.from_xml(xml_parsed)
    end
  end
end