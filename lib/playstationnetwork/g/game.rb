module PlayStationNetwork
  module G

    class Game
      attr_accessor :media, :updates, :trophies, :stats,
        :psn_id, :psn_hash, :psn_type, :psn_slug, :name, :cover, :platforms,
        :updated, :checked,
        :total, :platinum, :gold, :silver, :bronze,
        :points, :points_platinum, :average_percentage, :owners, :completers, :completers_platinum, :trophies_earned, :played_this_week

      def initialize(
          psn_id, psn_hash, psn_type, psn_slug, name, cover, platforms,
          updated, checked,
          artworks, videos,
          total, platinum, gold, silver, bronze,
          points, points_platinum, average_percentage, owners, completers, completers_platinum, trophies_earned, played_this_week
        )

        game_updates = Hash.new
        game_updates[:last_updated] = updated
        game_updates[:last_checked] = checked

        game_media = Hash.new
        game_media[:artworks] = artworks
        game_media[:videos]   = videos

        game_trophies = Hash.new
        game_trophies[:total]    = total
        game_trophies[:platinum] = platinum
        game_trophies[:gold]     = gold
        game_trophies[:silver]   = silver
        game_trophies[:bronze]   = bronze

        game_stats = Hash.new
        game_stats[:points]              = points
        game_stats[:points_platinum]     = points_platinum
        game_stats[:average_percentage]  = "#{average_percentage}%"
        game_stats[:owners]              = owners
        game_stats[:completers]          = completers
        game_stats[:completers_platinum] = completers_platinum
        game_stats[:trophies_earned]     = trophies_earned
        game_stats[:played_this_week]    = played_this_week

        self.psn_id    = psn_id
        self.psn_hash  = psn_hash
        self.psn_type  = psn_type
        self.psn_slug  = psn_slug
        self.name      = name
        self.cover     = cover
        self.platforms = platforms.split(',')
        self.media     = game_media
        self.updates   = game_updates
        self.trophies  = game_trophies
        self.stats     = game_stats
      end

      def self.find(psn_game_id)
        response = PlayStationNetwork::API.post("/psnGetGame",
                   PlayStationNetwork::API.config[:body].merge({ npcommid: psn_game_id }))

        if response.success?
          parsed = JSON.parse(response)

          new(
            parsed['npcommid'],
            parsed['game_hash'],
            parsed['content_Type'],
            parsed['unique_url'],
            parsed['title'],
            parsed['image'],
            parsed['pf'],
            parsed['updated'].to_i,
            parsed['meta_check'].to_i,
            parsed['screenshots'],
            parsed['videos'],
            parsed['total'].to_i,
            parsed['platinum'].to_i,
            parsed['gold'].to_i,
            parsed['silver'].to_i,
            parsed['bronze'].to_i,
            parsed['total_points'].to_i,
            parsed['total_points_plat'].to_i,
            parsed['average_perc'].to_f,
            parsed['owners'].to_i,
            parsed['completers'].to_i,
            parsed['platters'].to_i,
            parsed['trophies_earned'].to_i,
            parsed['played_this_week'].to_i
          )
        else
          raise response.response
        end
      end
    end

  end
end
