require 'test_helper'
require 'rexml/document'

class RoutesControllerTest < ActionController::TestCase
  include REXML

  test "should get latest routes in atom feed" do
    get :latest, {:format => 'atom'}
    assert_response :success
    assert assigns(:routes)
  end

  test "should have route info in atom feed" do
    route = Route.new(
      :grade    => '5.10a',
      :gym      => 'Earth Treks',
      :location => 'Rockville',
      :name     => 'The Climb',
      :rid      => '1234',
      :set_by   => 'Bob',
      :url      => 'http://route.com/1234'
    )
    route.types = [:lead, :toprope]
    route.save

    get :latest, {:format => 'atom'}

    xml = Document.new(@response.body)
    content = xml.elements['//entry/content']

    assert_match /The Climb/, content.text
  end
end
