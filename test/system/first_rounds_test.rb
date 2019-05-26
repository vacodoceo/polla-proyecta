require "application_system_test_case"

class FirstRoundsTest < ApplicationSystemTestCase
  setup do
    @first_round = first_rounds(:one)
  end

  test "visiting the index" do
    visit first_rounds_url
    assert_selector "h1", text: "First Rounds"
  end

  test "creating a First round" do
    visit first_rounds_url
    click_on "New First Round"

    fill_in "Country name", with: @first_round.country_name
    fill_in "Group", with: @first_round.group
    fill_in "Position", with: @first_round.position
    click_on "Create First round"

    assert_text "First round was successfully created"
    click_on "Back"
  end

  test "updating a First round" do
    visit first_rounds_url
    click_on "Edit", match: :first

    fill_in "Country name", with: @first_round.country_name
    fill_in "Group", with: @first_round.group
    fill_in "Position", with: @first_round.position
    click_on "Update First round"

    assert_text "First round was successfully updated"
    click_on "Back"
  end

  test "destroying a First round" do
    visit first_rounds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "First round was successfully destroyed"
  end
end
