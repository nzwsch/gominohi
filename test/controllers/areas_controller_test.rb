require "test_helper"

class AreasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get areas_index_url
    assert_response :success
  end
end
