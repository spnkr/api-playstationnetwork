module PSN
  class Games
    attr_accessor :total_games, :offset, :limit, :games

    def initialize(total_games, offset, limit, games)
      self.total_games = total_games
      self.offset      = offset
      self.limit       = limit
      self.games       = games
    end

    def self.find(username)
      response = PSN::API.get("/#{username}/trophies")

      if response.success?
        self.new(
          response['totalResults'],
          response['offset'],
          response['limit'],
          response['trophyTitles']
        )
      else
        raise response.response
      end
    end
  end
end
