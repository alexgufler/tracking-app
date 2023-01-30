require "test_helper"

class TrackingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tracking = trackings(:one)
  end

  test "should get index" do
    get trackings_url, as: :json
    assert_response :success
  end

  test "should create tracking" do
    assert_difference("Tracking.count") do
      post trackings_url, params: { tracking: { device: @tracking.device, ip: @tracking.ip, language: @tracking.language, location: @tracking.location, operating_system: @tracking.operating_system, referrer: @tracking.referrer, url: @tracking.url } }, as: :json
    end

    assert_response :created
  end

  test "should show tracking" do
    get tracking_url(@tracking), as: :json
    assert_response :success
  end

  test "should update tracking" do
    patch tracking_url(@tracking), params: { tracking: { device: @tracking.device, ip: @tracking.ip, language: @tracking.language, location: @tracking.location, operating_system: @tracking.operating_system, referrer: @tracking.referrer, url: @tracking.url } }, as: :json
    assert_response :success
  end

  test "should destroy tracking" do
    assert_difference("Tracking.count", -1) do
      delete tracking_url(@tracking), as: :json
    end

    assert_response :no_content
  end
end
