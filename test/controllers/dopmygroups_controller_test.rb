require "test_helper"

class DopmygroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dopmygroup = dopmygroups(:one)
  end

  test "should get index" do
    get dopmygroups_url
    assert_response :success
  end

  test "should get new" do
    get new_dopmygroup_url
    assert_response :success
  end

  test "should create dopmygroup" do
    assert_difference("Dopmygroup.count") do
      post dopmygroups_url, params: { dopmygroup: { comment: @dopmygroup.comment, countuser: @dopmygroup.countuser, mygroup_id: @dopmygroup.mygroup_id } }
    end

    assert_redirected_to dopmygroup_url(Dopmygroup.last)
  end

  test "should show dopmygroup" do
    get dopmygroup_url(@dopmygroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_dopmygroup_url(@dopmygroup)
    assert_response :success
  end

  test "should update dopmygroup" do
    patch dopmygroup_url(@dopmygroup), params: { dopmygroup: { comment: @dopmygroup.comment, countuser: @dopmygroup.countuser, mygroup_id: @dopmygroup.mygroup_id } }
    assert_redirected_to dopmygroup_url(@dopmygroup)
  end

  test "should destroy dopmygroup" do
    assert_difference("Dopmygroup.count", -1) do
      delete dopmygroup_url(@dopmygroup)
    end

    assert_redirected_to dopmygroups_url
  end
end
