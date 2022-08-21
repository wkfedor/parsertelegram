require "test_helper"

class WfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wfile = wfiles(:one)
  end

  test "should get index" do
    get wfiles_url
    assert_response :success
  end

  test "should get new" do
    get new_wfile_url
    assert_response :success
  end

  test "should create wfile" do
    assert_difference("Wfile.count") do
      post wfiles_url, params: { wfile: { dateold: @wfile.dateold, flag: @wfile.flag, word: @wfile.word } }
    end

    assert_redirected_to wfile_url(Wfile.last)
  end

  test "should show wfile" do
    get wfile_url(@wfile)
    assert_response :success
  end

  test "should get edit" do
    get edit_wfile_url(@wfile)
    assert_response :success
  end

  test "should update wfile" do
    patch wfile_url(@wfile), params: { wfile: { dateold: @wfile.dateold, flag: @wfile.flag, word: @wfile.word } }
    assert_redirected_to wfile_url(@wfile)
  end

  test "should destroy wfile" do
    assert_difference("Wfile.count", -1) do
      delete wfile_url(@wfile)
    end

    assert_redirected_to wfiles_url
  end
end
