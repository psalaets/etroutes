class Route < ActiveRecord::Base
  # Recognized route types. Routes can have one or more of these.
  TYPES = [:boulder, :lead, :toprope]

  attr_accessible :grade, :gym, :location, :name, :rid, :set_by, :url

  validates_presence_of :grade, :gym, :location, :name, :rid, :set_by, :url

  # Routes created in the last week, newest first.
  scope :latest, where('created_at > ?', 7.days.ago).order('created_at DESC')

  def types=(new_types)
    comma_delimited = (TYPES & new_types).join(',')
    write_attribute(:types, comma_delimited)
  end

  def types
    return [] unless types?
    read_attribute(:types).split(',').map(&:to_sym)
  end

  def to_tweet
    hashtagged_types = types.map { |type| hashtag(type) }.join(', ')
    middle = " #{grade} (#{hashtagged_types}) set by #{set_by} at #{gym} #{hashtag(location)} "

    tweetable_name = truncate(name, 140 - (middle.length + 20))

    "#{tweetable_name}#{middle}#{url}"
  end

  private

  def truncate(str, length)
    return str if str.length <= length

    suffix = '...'
    str[0, length - suffix.length] + suffix
  end

  def hashtag(str)
    "##{str.to_s.sub(/\s/, '')}"
  end
end
