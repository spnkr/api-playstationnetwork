module PlayStationNetwork
  module U

    class User
      attr_accessor :profile, :trophies, :points, :level, :stats,
        :membership, :avatar, :username, :about, :country, :region,
        :total, :platinum, :gold, :silver, :bronze, :total_possible,
        :points_base, :points, :points_next,
        :level, :projected_level, :progress, :projected_progress,
        :total_games, :completed_games, :completion_percentage, :world_rank, :region_rank, :hardcore_rank

      def initialize(
          membership, avatar, username, about, country, region,
          total, platinum, gold, silver, bronze, total_possible,
          points_base, points, points_next,
          level, projected_level, progress, projected_progress,
          total_games, completed_games, completion_percentage, world_rank, region_rank, hardcore_rank
        )

        # Build the Profile Hash
        #
        psn_profile = Hash.new
        psn_profile[:membership] = membership.to_i
        psn_profile[:avatar]     = avatar
        psn_profile[:username]   = username
        psn_profile[:about]      = about
        psn_profile[:location]   = Hash.new
        psn_profile[:location][:country] = country
        psn_profile[:location][:region]  = region

        # Build the Trophies hash
        #
        psn_profile_trophies = Hash.new
        psn_profile_trophies[:total]          = total.to_i
        psn_profile_trophies[:platinum]       = platinum.to_i
        psn_profile_trophies[:gold]           = gold.to_i
        psn_profile_trophies[:silver]         = silver.to_i
        psn_profile_trophies[:bronze]         = bronze.to_i
        psn_profile_trophies[:total_possible] = total_possible.to_i

        # Build the Points hash
        #
        psn_profile_points = Hash.new
        psn_profile_points[:base]   = points_base.to_i
        psn_profile_points[:actual] = points.to_i
        psn_profile_points[:next]   = points_next.to_i

        # Build the Level hash
        #
        psn_profile_level = Hash.new
        psn_profile_level[:level]              = level.to_i
        psn_profile_level[:projected_level]    = projected_level.to_i
        psn_profile_level[:progress]           = progress.to_f
        psn_profile_level[:projected_progress] = projected_progress.to_f

        # Build the Points hash
        #
        psn_profile_stats = Hash.new
        psn_profile_stats[:games]                 = total_games.to_i
        psn_profile_stats[:completed_games]       = completed_games.to_i
        psn_profile_stats[:completion_percentage] = completion_percentage.to_f
        psn_profile_stats[:rank]                  = Hash.new
        psn_profile_stats[:rank][:world_rank]     = world_rank.to_i
        psn_profile_stats[:rank][:region_rank]    = region_rank.to_i
        psn_profile_stats[:rank][:hardcore_rank]  = hardcore_rank.to_i

        self.profile  = psn_profile
        self.trophies = psn_profile_trophies
        self.level    = psn_profile_level
        self.points   = psn_profile_points
        self.stats    = psn_profile_stats

      end

      def self.profile(psn_user_id)
        response = PlayStationNetwork::API.post('/psnGetUser',
                   PlayStationNetwork::API.config[:body].merge({ user_id: psn_user_id }))

        if response.success?
          parsed = JSON.parse(response)

          self.new(
            parsed['psnplus'],
            parsed['avatar'],
            parsed['psn_id'],
            parsed['about_me'],
            parsed['country'],
            parsed['region'],

            parsed['total'],
            parsed['platinum'],
            parsed['gold'],
            parsed['silver'],
            parsed['bronze'],
            parsed['total_possible_trophies'],

            parsed['base'],
            parsed['points'],
            parsed['next'],

            parsed['level'],
            parsed['projected_level'],
            parsed['progress'],
            parsed['projected_progress'],

            parsed['total_games'],
            parsed['games_complete'],
            parsed['completion_percentage'],
            parsed['worldrank'],
            parsed['regionrank'],
            parsed['hardcore_rank']

          )
        else
          raise response.response
        end
      end
    end

  end
end
