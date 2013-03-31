require 'test_helper'
require 'rexml/document'

class RoutesControllerTest < ActionController::TestCase
  include REXML

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
    @route.save
  end

  test "should get latest routes in atom feed" do
    get :latest, {:format => 'atom'}

    assert_response :success
    assert assigns(:routes)
  end

  test "should have route info in atom feed" do
    get :latest, {:format => 'atom'}

    xml = Document.new(@response.body)
    content = xml.elements['/feed/entry[1]/content']

    assert_match /The Climb/, content.text
  end

  test "IFTTT requirement: feed has top level title" do
    get :latest, {:format => 'atom'}

    xml = Document.new(@response.body)

    assert xml.elements['/feed/title'].text
  end

  test "IFTTT requirement: entries have id" do
    get :latest, {:format => 'atom'}

    xml = Document.new(@response.body)

    assert xml.elements['/feed/entry[1]/id'].text
  end

  test "IFTTT requirement: entries have date(s)" do
    get :latest, {:format => 'atom'}

    xml = Document.new(@response.body)

    assert xml.elements['/feed/entry[1]/updated'].text
    assert xml.elements['/feed/entry[1]/published'].text
  end

  test "IFTTT requirement: entries have url" do
    get :latest, {:format => 'atom'}

    xml = Document.new(@response.body)

    assert xml.elements['/feed/entry[1]/link[@rel="alternate"]'].attributes['href']
  end
end
