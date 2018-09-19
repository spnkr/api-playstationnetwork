module PlayStationNetwork
  class Store
    include HTTParty
    base_uri "https://store.playstation.com"

    attr_reader :args, :region, :language

    def initialize(args, region: 'GB', language: 'en')
      @args = args
      @region = region
      @language = language
    end

    def search(game_type = 'Full Game')
      raise '' unless game_type != 'Full Game' || game_type != 'Bundle'

      options = {
        headers: {
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36",
          "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
          "Authority" => "store.playstation.com"
        },
        
        query: {
          suggested_size: 5,
          mode: 'game'
        }
      }

      request = self.class.get(search_url(args), options)

      if request.success?
        response = []

        results = request.parsed_response['included'].select do |result|
          result['attributes']['game-content-type'] == game_type
        end

        results.each do |result|
          response << {
            store_id: result['id'],
            name: result['attributes']['name'],
            description: result['attributes']['long-description'],
            type: result['type'],
            raw: result
          }
        end

        return response
      else
        raise request.response
      end
    end

    def details
      options = {
        headers: {
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36",
          "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
          "Authority" => "store.playstation.com"
        }
      }

      request = self.class.get(details_url(args), options)

      if request.success?
        return request.parsed_response
      else
        raise request.response
      end
    end

  private

    def search_url(query)
      "/valkyrie-api/#{ language }/#{ region }/19/tumbler-search/#{ URI.encode(query) }"
    end

    def details_url(identifier)
      "/store/api/chihiro/00_09_000/container/#{ region }/#{ language }/19/#{ identifier }"
    end
  end
end