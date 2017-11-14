module PlayStationNetwork
  VERSION ||= '2.1.2'

  def self.changelog
    puts "
      v0.0

      v0.0.1 - Initial
      v0.0.2 - Added Trophy Information
      v0.0.3 - Added Trophies offset
      v0.1.0 - Pluralized Renamed Trophy and TrophyGroup classes
      v0.1.1 - Added a convenient method 'all' on Trophies, without having to pass the group id as an argument
    
      v1.0  - This version is not backwards compatible! Read below for new API endpoints
     
      v1.0.0 - Introduces a new API source and a new format
      v1.0.1 - Fixes a bug where ActiveSupport version would cause an issue with existing rails apps
      v1.0.2 - Adds correct hash format to pass the api key and secret to each route
    
      v2.0 - This version is not backwards compatible! Read below for new API endpoints
     
      v2.0.0
        - Simplified API calls. Instead of separating each endpoint into its own file, use one file per class
        - Remove all dependencies except HTTParty and use native Ruby where dependency was required
        - No more parsing the data inside the gem, instead return the RAW data and let the application decide how to parse it

        ## Old method -> New method ( PlayStationNetwork:: removed for breviety )
        #
        # User
        #
        Profile:    ::U::User.profile('pacMakaveli90')                 -> ::User.new('pacMakaveli90').profile
        Games:      ::U::Games.all('pacMakaveli90')                    -> ::User.new('pacMakaveli90').games
        Trophies:   ::U::Trophies.all('pacMakaveli90', 'NPWR00132_00') -> ::User.new('pacMakaveli90').trophies('NPWR00132_00')
        
        # Games
        #
        Game:       ::G::Game.find('NPWR00132_00')                     -> ::Game.new('NPWR00132_00').details
        Trophies:   ::G::Trophies.all('NPWR00132_00')                  -> ::Game.new('NPWR00132_00').trophies
        All:        ::G::Games.all('all')                              -> ::Game.new().all(platform: 'ps4') # default 'all'
        Popular:    ::G::Games.popular()                               -> ::Game.new().all(popular: true)

      v2.0.1
        - When requesting Games for a specific user, return only the games instead of a full response which returns the same data that ::User.new('pacMakaveli90').profile already returns

      v2.1.0
        - Added 'verify: false' to HTTParty default options to skip any SSL certification errors. Temporary measure until we can figure how to fix this.

      v2.1.1
        - Tidy up the code and add a new option which should make internal calls cleaner

      v2.1.2
        - Added 'verify: false' option introduced in v2.1.0 as a configurable option in the initializer
    "
  end
end
