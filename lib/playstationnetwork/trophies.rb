module PlayStationNetwork

  class Trophies
    attr_accessor :psn_id, :group_id, :trophies #, :trophy_id, :hidden, :type, :name, :description, :cover, :rarity, :earned_rate

    def initialize(psn_id, group_id, trophies)# trophy_id, hidden, type, name, description, cover, rarity, earned_rate)
      self.psn_id      = psn_id
      self.group_id    = group_id
      self.trophies    = trophies
      # self.trophy_id   = trophy_id
      # self.hidden      = hidden
      # self.type        = type
      # self.name        = name
      # self.description = description
      # self.cover       = cover
      # self.rarity      = rarity
      # self.earned_rate = earned_rate
    end

    def self.find(username, game_id, group_id)
      response = PlayStationNetwork::API.get("/#{username}/trophies/#{game_id}/groups/#{group_id}")

      if response.success?
        new(
          game_id,
          group_id,
          response['trophies']
          # response['trophyId'],
          # response['trophyHidden'],
          # response['trophyType'],
          # response['trophyName'],
          # response['trophyDetail'],
          # response['trophyIconUrl'],
          # response['trophyRare'],
          # response['trophyEarnedRate']
        )
      else
        raise response.response
      end
    end

    def self.all(username, game_id)
      response = PlayStationNetwork::API.get("/#{username}/trophies/#{game_id}")

      if response.success?
        new(
          game_id,
          nil,
          response['trophies']
          # response['trophyId'],
          # response['trophyHidden'],
          # response['trophyType'],
          # response['trophyName'],
          # response['trophyDetail'],
          # response['trophyIconUrl'],
          # response['trophyRare'],
          # response['trophyEarnedRate']
        )
      else
        raise response.response
      end
    end
  end
end
