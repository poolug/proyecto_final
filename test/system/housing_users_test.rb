require "application_system_test_case"

class HousingUsersTest < ApplicationSystemTestCase
  setup do
    @housing_user = housing_users(:one)
  end

  test "visiting the index" do
    visit housing_users_url
    assert_selector "h1", text: "Housing Users"
  end

  test "creating a Housing user" do
    visit housing_users_url
    click_on "New Housing User"

    click_on "Create Housing user"

    assert_text "Housing user was successfully created"
    click_on "Back"
  end

  test "updating a Housing user" do
    visit housing_users_url
    click_on "Edit", match: :first

    click_on "Update Housing user"

    assert_text "Housing user was successfully updated"
    click_on "Back"
  end

  test "destroying a Housing user" do
    visit housing_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Housing user was successfully destroyed"
  end
end
