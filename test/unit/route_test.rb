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
      r.created_at = (i * 7).days.ago
      r.save
      routes << r
    end

    young, older, too_old = routes

    latest = Route.latest

    assert_equal([young, older], latest)
  end

  test "Routes.latest are ordered by descending id when created at is the same" do
    created_at = 1.days.ago

    2.times do |i|
      r = Route.create(
        :name     => "Climb #{i}",
        :grade    => '5.8',
        :gym      => 'Earth Treks',
        :location => 'Rockville',
        :rid      => '1234',
        :set_by   => 'Bob',
        :url      => 'http://route.com/1234'
      )
      r.created_at = created_at
      r.save
    end

    latest = Route.latest

    assert_equal(latest.first.created_at, latest.last.created_at)
    assert(latest.first.id > latest.last.id)
  end

  test "Route.old are Routes older than 1 week" do
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
      r.created_at = (i * 7).days.ago
      r.save
      routes << r
    end

    young, older, too_old = routes

    old_routes = Route.old

    assert_equal([too_old], old_routes)
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

  test "guid is set automatically when route is created" do
    assert !@valid_route.guid

    @valid_route.save

    assert @valid_route.guid
  end
end
