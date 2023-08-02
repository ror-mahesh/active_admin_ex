require "test_helper"

class CoachParTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coach_par_time = coach_par_times(:one)
  end

  test "should get index" do
    get coach_par_times_url
    assert_response :success
  end

  test "should get new" do
    get new_coach_par_time_url
    assert_response :success
  end

  test "should create coach_par_time" do
    assert_difference("CoachParTime.count") do
      post coach_par_times_url, params: { coach_par_time: { booked_slot: @coach_par_time.booked_slot, coach_par_avail_id: @coach_par_time.coach_par_avail_id, dates: @coach_par_time.dates, from: @coach_par_time.from, sno: @coach_par_time.sno, to: @coach_par_time.to } }
    end

    assert_redirected_to coach_par_time_url(CoachParTime.last)
  end

  test "should show coach_par_time" do
    get coach_par_time_url(@coach_par_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_coach_par_time_url(@coach_par_time)
    assert_response :success
  end

  test "should update coach_par_time" do
    patch coach_par_time_url(@coach_par_time), params: { coach_par_time: { booked_slot: @coach_par_time.booked_slot, coach_par_avail_id: @coach_par_time.coach_par_avail_id, dates: @coach_par_time.dates, from: @coach_par_time.from, sno: @coach_par_time.sno, to: @coach_par_time.to } }
    assert_redirected_to coach_par_time_url(@coach_par_time)
  end

  test "should destroy coach_par_time" do
    assert_difference("CoachParTime.count", -1) do
      delete coach_par_time_url(@coach_par_time)
    end

    assert_redirected_to coach_par_times_url
  end
end
