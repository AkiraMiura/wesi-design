require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "水しるべ調査"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "ホーム | #{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "このサイトについて | #{@base_title}"
  end

end
