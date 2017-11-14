module PlayStationNetwork
  class Configuration
    attr_writer :key, :secret, :url, :verify_ssl

    def key
      @key
    end

    def secret
      @secret
    end

    def url
      @url
    end

    def verify_ssl
      @verify_ssl
    end
  end

  def self.configure(&block)
    block.call(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  module API
    include HTTParty
    
    # base_uri ""

    extend self

    MISSING_CONFIGURATION ||= "You must configure the PlayStationNetwork module before using this Gem. See the README.md for how to configure it"
    MISSING_URL ||= "You must pass the 'url' to the PlayStationNetwork module before using this Gem. See the README.md for how to configure it"
    MISSING_KEY ||= "You must pass your 'key' to the PlayStationNetwork module before using this Gem. See the README.md for how to configure it"
    MISSING_SECRET ||= "You must pass your 'secret' to the PlayStationNetwork module before using this Gem. See the README.md for how to configure it"

    def request
      handle_response do
        raise MISSING_CONFIGURATION if PlayStationNetwork.configuration.nil?
        raise MISSING_KEY if PlayStationNetwork.configuration.key.nil?
        raise MISSING_SECRET if PlayStationNetwork.configuration.secret.nil?
        raise MISSING_URL if PlayStationNetwork.configuration.url.nil?

        default_options.update(base_uri: PlayStationNetwork.configuration.url)
        default_options.update(verify: PlayStationNetwork.configuration.verify_ssl)

        return {
          api_key: PlayStationNetwork.configuration.key,
          api_secret: PlayStationNetwork.configuration.secret,
          response_type: 'json'
        }
      end
    end

    def handle_response(&block)
      yield
    rescue => e
      {
        success: false,
        code: 500,
        message: e
      }
    end

    def parse_response(url, options, reduce_to = {})
      request = post(url, body: options)

      if request.success?
        begin
          if reduce_to.blank?
            JSON.parse(request)
          else
            JSON.parse(request)[reduce_to]
          end
        rescue
          raise "There was a problem parsing the JSON. Most likely an API problem."
        end
      else
        raise request.response
      end
    end
  end
end
