require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  def setup
    @valid_route = Route.new(
      :grade    => '5.10a',
      :gym      => 'Earth Treks',
      :location => 'Rockville',
      :name     => 'The Climb',
      :rid      => '1234',
      :set_by   => 'Bob',
      :url      => 'http://route.com/1234'
    )
    @valid_route.types = [:lead, :toprope]
  end

  test "types starts out empty" do
    r = Route.new

    assert_equal([], r.types)
  end

  test "types is a collection of Symbols" do
    @valid_route.types = [:lead, :toprope]

    assert_equal([:lead, :toprope], @valid_route.types)
  end

  test "types= ignores unrecognized type Symbols" do
    @valid_route.types = [:boulder, :not_a_type]

    assert_equal([:boulder], @valid_route.types)
  end

  test "saving and loading types" do
    @valid_route.types = [:lead, :toprope]
    @valid_route.save

    r = Route.find(@valid_route.id)

    assert_equal([:lead, :toprope], r.types)
  end

  test "Route.latest is last week's worth of Routes, newest first" do
    routes = []
    3.times do |i|
      r = Route.create(
        :name     => "Climb #{i}",
        :grade    => '5.8',
        :gym      => 'Earth Treks',
        :location => 'Rockville',
        :rid      => '1234',
        :set_by   => 'Bob',
        :url      => 'http://route.com/1234'
      )
      r.created_at = (i * 5).days.ago
      r.save
      routes << r
    end

    young, older, too_old = routes

    latest = Route.latest

    assert_equal([young, older], latest)
  end

  test "name is required" do
    @valid_route.name = nil

    assert !@valid_route.save
  end

  test "grade is required" do
    @valid_route.grade = nil

    assert !@valid_route.save
  end

  test "gym is required" do
    @valid_route.gym = nil

    assert !@valid_route.save
  end

  test "location is required" do
    @valid_route.location = nil

    assert !@valid_route.save
  end

  test "rid is required" do
    @valid_route.rid = nil

    assert !@valid_route.save
  end

  test "set_by is required" do
    @valid_route.set_by = nil

    assert !@valid_route.save
  end

  test "url is required" do
    @valid_route.url = nil

    assert !@valid_route.save
  end

  test "can format itself as a tweet" do
    tweet = @valid_route.to_tweet

    expected = "The Climb 5.10a (#lead, #toprope) set by Bob at Earth Treks #Rockville http://route.com/1234"

    assert_equal expected, tweet
  end

  test "removes spaces from hashtags in tweet" do
    @valid_route.location = 'The City'
    tweet = @valid_route.to_tweet

    expected = "The Climb 5.10a (#lead, #toprope) set by Bob at Earth Treks #TheCity http://route.com/1234"

    assert_equal expected, tweet
  end

  test "abbreviates name if tweet is too long" do
    # name is too long for a tweet
    @valid_route.name = 'a' * 150

    tweet = @valid_route.to_tweet

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
