module PlayStationNetwork
  class Profile
    attr_accessor :id,
                  :avatar,
                  :username,
                  :about,
                  :membership,
                  :level,
                  :progress,
                  :trophies

    def initialize(id, avatar, username, about, membership, level, progress, trophies)
      self.id         = id
      self.avatar     = avatar
      self.username   = username
      self.about      = about
      self.membership = membership
      self.level      = level
      self.progress   = progress
      self.trophies   = trophies
    end

    def self.find(username)
      response = PlayStationNetwork::API.get("/#{username}")

      if response.success?
        self.new(
          response['npId'],
          response['avatarUrl'],
          response['onlineId'],
          response['aboutMe'],
          response['plus'],
          response['trophySummary']['level'],
          response['trophySummary']['progress'],
          response['trophySummary']['earnedTrophies']
        )
      else
        raise response.response
      end
    end
  end
end
