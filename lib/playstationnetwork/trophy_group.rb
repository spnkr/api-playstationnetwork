module PlayStationNetwork

  class TrophyGroup
    attr_accessor :psn_id, :groups #:group_id, :name, :description, :cover, :defined_trophies

    def initialize(psn_id, groups) # group_id, name, description, cover, defined_trophies)

      self.psn_id           = psn_id
      self.groups           = groups
      # self.group_id         = group_id
      # self.name             = name
      # self.description      = description
      # self.cover            = cover
      # self.defined_trophies = defined_trophies
    end

    def self.find(username, game_id)
      response = PlayStationNetwork::API.get("/#{username}/trophies/#{game_id}/groups")

      if response.success?
        new(
          game_id,
          response['trophyGroups']
        )
      else
        raise response.response
      end
    end
  end
end
