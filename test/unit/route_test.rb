require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  test "types starts out empty" do
    r = Route.new

    assert_equal([], r.types)
  end

  test "types is a collection of Symbols" do
    r = Route.new

    r.types = [:lead, :toprope]

    assert_equal([:lead, :toprope], r.types)
  end

  test "types= ignores unrecognized type Symbols" do
    r = Route.new

    r.types = [:boulder, :not_a_type]

    assert_equal([:boulder], r.types)
  end

  test "saving and loading types" do
    r = Route.new

    r.types = [:lead, :toprope]
    r.save

    r = Route.find(r.id)

    assert_equal([:lead, :toprope], r.types)
  end

  test "Route.latest is last week's worth of Routes, newest first" do
    routes = []
    3.times do |i|
      r = Route.create
      r.created_at = (i * 5).days.ago
      r.save
      routes << r
    end

    young, older, too_old = routes

    latest = Route.latest

    assert_equal([young, older], latest)
  end
end
