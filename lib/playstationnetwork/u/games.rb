module PlayStationNetwork
  module U

    class Games
      attr_accessor :total_games, :games

      def initialize(total_games, games)
        self.total_games = total_games
        self.games       = games
      end

      def self.all(psn_user_id)
        response = PlayStationNetwork::API.post('/psnGetUserGames',
                   PlayStationNetwork::API.config[:body].merge({ user_id: psn_user_id }))

        if response.success?
          parsed = JSON.parse(response)

          new(
            parsed['games'].size,
            parsed['games']
          )
        else
          raise response.response
        end
      end
    end

  end
end
