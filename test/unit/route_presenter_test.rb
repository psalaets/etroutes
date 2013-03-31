require 'test_helper'

class RoutePresenterTest < ActiveSupport::TestCase
  def setup
    @route = Route.new(
      :grade    => '5.10a',
      :gym      => 'Earth Treks',
      :location => 'Rockville',
      :name     => 'The Climb',
      :rid      => '1234',
      :set_by   => 'Bob',
      :url      => 'http://route.com/1234'
    )
    @route.types = [:lead, :toprope]

    @presenter = RoutePresenter.new(@route)
  end

  test "can format route into a tweet" do
    tweet = @presenter.to_tweet

    expected = "The Climb 5.10a (#lead, #toprope) set by Bob at Earth Treks #Rockville http://route.com/1234"

    assert_equal expected, tweet
  end

  test "removes spaces from location hashtag" do
    @route.location = 'The City'
    tweet = @presenter.to_tweet

    expected = "The Climb 5.10a (#lead, #toprope) set by Bob at Earth Treks #TheCity http://route.com/1234"

    assert_equal expected, tweet
  end

  test "abbreviates name if tweet is too long" do
    # name is too long for a tweet
    @route.name = 'a' * 150

    tweet = @presenter.to_tweet

    # 62 chars
    middle = " 5.10a (#lead, #toprope) set by Bob at Earth Treks #Rockville "
    # counts as 20 chars
    url = "http://route.com/1234"

    name = "a" * (140 - (62 + 20 + 3))
    name << '...'

    expected = "#{name}#{middle}#{url}"

    assert_equal expected, tweet
  end
end