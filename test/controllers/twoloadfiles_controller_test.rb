require "test_helper"

class TwoloadfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twoloadfile = twoloadfiles(:one)
  end

  test "should get index" do
    get twoloadfiles_url
    assert_response :success
  end

  test "should get new" do
    get new_twoloadfile_url
    assert_response :success
  end

  test "should create twoloadfile" do
    assert_difference("Twoloadfile.count") do
      post twoloadfiles_url, params: { twoloadfile: { comment: @twoloadfile.comment, lfilename: @twoloadfile.lfilename } }
    end

    assert_redirected_to twoloadfile_url(Twoloadfile.last)
  end

  test "should show twoloadfile" do
    get twoloadfile_url(@twoloadfile)
    assert_response :success
  end

  test "should get edit" do
    get edit_twoloadfile_url(@twoloadfile)
    assert_response :success
  end

  test "should update twoloadfile" do
    patch twoloadfile_url(@twoloadfile), params: { twoloadfile: { comment: @twoloadfile.comment, lfilename: @twoloadfile.lfilename } }
    assert_redirected_to twoloadfile_url(@twoloadfile)
  end

  test "should destroy twoloadfile" do
    assert_difference("Twoloadfile.count", -1) do
      delete twoloadfile_url(@twoloadfile)
    end

    assert_redirected_to twoloadfiles_url
  end
end
