require "application_system_test_case"

class CoachParAvailsTest < ApplicationSystemTestCase
  setup do
    @coach_par_avail = coach_par_avails(:one)
  end

  test "visiting the index" do
    visit coach_par_avails_url
    assert_selector "h1", text: "Coach par avails"
  end

  test "should create coach par avail" do
    visit coach_par_avails_url
    click_on "New coach par avail"

    fill_in "Account", with: @coach_par_avail.account_id
    fill_in "End date", with: @coach_par_avail.end_date
    fill_in "Start date", with: @coach_par_avail.start_date
    click_on "Create Coach par avail"

    assert_text "Coach par avail was successfully created"
    click_on "Back"
  end

  test "should update Coach par avail" do
    visit coach_par_avail_url(@coach_par_avail)
    click_on "Edit this coach par avail", match: :first

    fill_in "Account", with: @coach_par_avail.account_id
    fill_in "End date", with: @coach_par_avail.end_date
    fill_in "Start date", with: @coach_par_avail.start_date
    click_on "Update Coach par avail"

    assert_text "Coach par avail was successfully updated"
    click_on "Back"
  end

  test "should destroy Coach par avail" do
    visit coach_par_avail_url(@coach_par_avail)
    click_on "Destroy this coach par avail", match: :first

    assert_text "Coach par avail was successfully destroyed"
  end
end
