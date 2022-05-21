require "test_helper"

class CollectionDatesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get collection_dates_show_url
    assert_response :success
  end
end
