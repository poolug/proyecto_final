require 'test_helper'

class HousingUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @housing_user = housing_users(:one)
  end

  test "should get index" do
    get housing_users_url
    assert_response :success
  end

  test "should get new" do
    get new_housing_user_url
    assert_response :success
  end

  test "should create housing_user" do
    assert_difference('HousingUser.count') do
      post housing_users_url, params: { housing_user: {  } }
    end

    assert_redirected_to housing_user_url(HousingUser.last)
  end

  test "should show housing_user" do
    get housing_user_url(@housing_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_housing_user_url(@housing_user)
    assert_response :success
  end

  test "should update housing_user" do
    patch housing_user_url(@housing_user), params: { housing_user: {  } }
    assert_redirected_to housing_user_url(@housing_user)
  end

  test "should destroy housing_user" do
    assert_difference('HousingUser.count', -1) do
      delete housing_user_url(@housing_user)
    end

    assert_redirected_to housing_users_url
  end
end
