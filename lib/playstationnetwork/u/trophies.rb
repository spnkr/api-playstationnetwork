module PlayStationNetwork
  module U

    class Trophies
      attr_accessor :trophies

      def initialize(trophies)
        self.trophies = trophies
      end

      def self.all(psn_user_id, psn_game_id)
        response = PlayStationNetwork::API.post('/psnGetUserTrophies',
                   PlayStationNetwork::API.config[:body].merge({ user_id: psn_user_id, npcommid: psn_game_id }))

        if response.success?
          parsed = JSON.parse(response)

          new(
            parsed['trophies']
          )
        else
          raise response.response
        end
      end
    end

  end
end