class RoutePresenter
  def initialize(route)
    @route = route
  end

  def to_tweet
    middle = " (#{@route.grade}) set by #{@route.set_by} at #{hashtag(@route.location)} "

    name = truncate(@route.name, 140 - (middle.length + 20), '...')

    "#{name}#{middle}#{@route.url}"
  end

  private

  # Return a String with a capped length.
  #
  # str        - String to shorten.
  # max_length - Maximum allowed length of str.
  # suffix     - If str needed to be shortened, add this suffix to it.
  #
  # Returns shortened version of str with suffix appended if it was longer than
  # max_length. Otherwise returns str as is. Value returned will never be longer
  # than max_length.
  def truncate(str, max_length, suffix)
    return str if str.length <= max_length
    str[0, max_length - suffix.length] + suffix
  end

  # Remove spaces from a String and put a # on the front.
  def hashtag(str)
    "##{str.to_s.sub(/\s/, '')}"
  end
end