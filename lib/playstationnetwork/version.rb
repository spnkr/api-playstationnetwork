module PlayStationNetwork
  VERSION = '1.0.2'

  # Changelog
  #

  #
  # v0.0.1 - Initial
  # v0.0.2 - Added Trophy Information
  # v0.0.3 - Added Trophies offset
  # v0.1.0 - Pluralized Renamed Trophy and TrophyGroup classes
  # v0.1.1 - Added a convenient method 'all' on Trophies, without having to pass
  # the group id as an argument

  #
  # v1.0.0 - Introduces a new API, new endpoints and new format for requesting data
  # it's basically a new gem
  # v1.0.1 - Fixes a bug where activesupport version would cause an issue with existing
  # rails apps
  # v1.0.2 - Adds correct hash format to pass the api key and secret to each route
end
