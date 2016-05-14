require 'json'
require 'active_support/core_ext/hash'
require 'pp'

module PlayStationNetwork
  module G

    class Games
      attr_accessor :success, :total_games, :games

      def initialize(success, total_games, games)
        self.success     = success
        self.total_games = total_games
        self.games       = games
      end

      # Available platform options
      #
      # => all returns all PlayStation Network games
      # => psp2 returns all PSP games
      # => ps3 returns all PS3 games
      # => ps4 returns all PS4 games
      #
      def self.all(psn_platform = 'all')
        response = PlayStationNetwork::API.post('/psnListGames',
                   PlayStationNetwork::API.config[:body].merge({ platform: psn_platform }))

        sanitized_response = response.gsub('<?xml version=\"1.0\"?>', '').gsub('<\/', '</').tr('"', '')
        parsed_response    = Hash.from_xml(sanitized_response)

        if response.success?
          new(
            (parsed_response['psn_api']['success'].to_i == 1 ? true : false),
            parsed_response['psn_api']['game'].size,
            parsed_response['psn_api']['game']
          )
        else
          raise response.response
        end
      end

      def self.popular
        response = PlayStationNetwork::API.post('/psnPopularThisWeek')

        sanitized_response = response.gsub('<?xml version=\"1.0\"?>', '').gsub('<\/', '</').tr('"', '')
        parsed_response    = Hash.from_xml(sanitized_response)

        if response.success?
          new(
            (parsed_response['psn_api']['success'].to_i == 1 ? true : false),
            parsed_response['psn_api']['game'].size,
            parsed_response['psn_api']['game']
          )
        else
          raise response.response
        end
      end

    end
  end
end
