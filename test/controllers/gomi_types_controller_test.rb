require "test_helper"

class GomiTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gomi_types_index_url
    assert_response :success
  end

  test "should get show" do
    get gomi_types_show_url
    assert_response :success
  end
end
