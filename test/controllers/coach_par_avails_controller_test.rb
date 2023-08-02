require "test_helper"

class CoachParAvailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coach_par_avail = coach_par_avails(:one)
  end

  test "should get index" do
    get coach_par_avails_url
    assert_response :success
  end

  test "should get new" do
    get new_coach_par_avail_url
    assert_response :success
  end

  test "should create coach_par_avail" do
    assert_difference("CoachParAvail.count") do
      post coach_par_avails_url, params: { coach_par_avail: { account_id: @coach_par_avail.account_id, end_date: @coach_par_avail.end_date, start_date: @coach_par_avail.start_date } }
    end

    assert_redirected_to coach_par_avail_url(CoachParAvail.last)
  end

  test "should show coach_par_avail" do
    get coach_par_avail_url(@coach_par_avail)
    assert_response :success
  end

  test "should get edit" do
    get edit_coach_par_avail_url(@coach_par_avail)
    assert_response :success
  end

  test "should update coach_par_avail" do
    patch coach_par_avail_url(@coach_par_avail), params: { coach_par_avail: { account_id: @coach_par_avail.account_id, end_date: @coach_par_avail.end_date, start_date: @coach_par_avail.start_date } }
    assert_redirected_to coach_par_avail_url(@coach_par_avail)
  end

  test "should destroy coach_par_avail" do
    assert_difference("CoachParAvail.count", -1) do
      delete coach_par_avail_url(@coach_par_avail)
    end

    assert_redirected_to coach_par_avails_url
  end
end
