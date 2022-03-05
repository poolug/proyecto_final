require "application_system_test_case"

class HousingsTest < ApplicationSystemTestCase
  setup do
    @housing = housings(:one)
  end

  test "visiting the index" do
    visit housings_url
    assert_selector "h1", text: "Housings"
  end

  test "creating a Housing" do
    visit housings_url
    click_on "New Housing"

    click_on "Create Housing"

    assert_text "Housing was successfully created"
    click_on "Back"
  end

  test "updating a Housing" do
    visit housings_url
    click_on "Edit", match: :first

    click_on "Update Housing"

    assert_text "Housing was successfully updated"
    click_on "Back"
  end

  test "destroying a Housing" do
    visit housings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Housing was successfully destroyed"
  end
end
