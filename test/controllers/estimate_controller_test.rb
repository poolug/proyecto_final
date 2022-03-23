require 'test_helper'

class EstimateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estimate_index_url
    assert_response :success
  end

end
