require "test_helper"

class LoadfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loadfile = loadfiles(:one)
  end

  test "should get index" do
    get loadfiles_url
    assert_response :success
  end

  test "should get new" do
    get new_loadfile_url
    assert_response :success
  end

  test "should create loadfile" do
    assert_difference("Loadfile.count") do
      post loadfiles_url, params: { loadfile: { comment: @loadfile.comment, lfilename: @loadfile.lfilename } }
    end

    assert_redirected_to loadfile_url(Loadfile.last)
  end

  test "should show loadfile" do
    get loadfile_url(@loadfile)
    assert_response :success
  end

  test "should get edit" do
    get edit_loadfile_url(@loadfile)
    assert_response :success
  end

  test "should update loadfile" do
    patch loadfile_url(@loadfile), params: { loadfile: { comment: @loadfile.comment, lfilename: @loadfile.lfilename } }
    assert_redirected_to loadfile_url(@loadfile)
  end

  test "should destroy loadfile" do
    assert_difference("Loadfile.count", -1) do
      delete loadfile_url(@loadfile)
    end

    assert_redirected_to loadfiles_url
  end
end
