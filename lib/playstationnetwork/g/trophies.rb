module PlayStationNetwork
  module G

    class Trophies
      attr_accessor :psn_id, :image_prefix, :trophies, :groups

      def initialize(psn_id, image_prefix, trophies, groups)
        self.psn_id       = psn_id
        self.image_prefix = image_prefix
        self.trophies     = trophies
        self.groups       = groups
      end

      def self.all(psn_game_id)
        response = PlayStationNetwork::API.post('/psnGetTrophies',
                   PlayStationNetwork::API.config[:body].merge({ npcommid: psn_game_id }))

        if response.success?
          parsed = JSON.parse(response)

          new(
            parsed['npcommid'],
            parsed['image_prefix'],
            parsed['trophies'],
            parsed['groups']
          )
        else
          raise response.response
        end
      end
    end

  end
end
