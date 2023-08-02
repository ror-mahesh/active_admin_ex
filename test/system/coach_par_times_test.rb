require "application_system_test_case"

class CoachParTimesTest < ApplicationSystemTestCase
  setup do
    @coach_par_time = coach_par_times(:one)
  end

  test "visiting the index" do
    visit coach_par_times_url
    assert_selector "h1", text: "Coach par times"
  end

  test "should create coach par time" do
    visit coach_par_times_url
    click_on "New coach par time"

    check "Booked slot" if @coach_par_time.booked_slot
    fill_in "Coach par avail", with: @coach_par_time.coach_par_avail_id
    fill_in "Dates", with: @coach_par_time.dates
    fill_in "From", with: @coach_par_time.from
    fill_in "Sno", with: @coach_par_time.sno
    fill_in "To", with: @coach_par_time.to
    click_on "Create Coach par time"

    assert_text "Coach par time was successfully created"
    click_on "Back"
  end

  test "should update Coach par time" do
    visit coach_par_time_url(@coach_par_time)
    click_on "Edit this coach par time", match: :first

    check "Booked slot" if @coach_par_time.booked_slot
    fill_in "Coach par avail", with: @coach_par_time.coach_par_avail_id
    fill_in "Dates", with: @coach_par_time.dates
    fill_in "From", with: @coach_par_time.from
    fill_in "Sno", with: @coach_par_time.sno
    fill_in "To", with: @coach_par_time.to
    click_on "Update Coach par time"

    assert_text "Coach par time was successfully updated"
    click_on "Back"
  end

  test "should destroy Coach par time" do
    visit coach_par_time_url(@coach_par_time)
    click_on "Destroy this coach par time", match: :first

    assert_text "Coach par time was successfully destroyed"
  end
end
