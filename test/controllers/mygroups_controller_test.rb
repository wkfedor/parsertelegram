require "test_helper"

class MygroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mygroup = mygroups(:one)
  end

  test "should get index" do
    get mygroups_url
    assert_response :success
  end

  test "should get new" do
    get new_mygroup_url
    assert_response :success
  end

  test "should create mygroup" do
    assert_difference("Mygroup.count") do
      post mygroups_url, params: { mygroup: { countuser: @mygroup.countuser, datein: @mygroup.datein, description: @mygroup.description, iid: @mygroup.iid, title: @mygroup.title, username: @mygroup.username } }
    end

    assert_redirected_to mygroup_url(Mygroup.last)
  end

  test "should show mygroup" do
    get mygroup_url(@mygroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_mygroup_url(@mygroup)
    assert_response :success
  end

  test "should update mygroup" do
    patch mygroup_url(@mygroup), params: { mygroup: { countuser: @mygroup.countuser, datein: @mygroup.datein, description: @mygroup.description, iid: @mygroup.iid, title: @mygroup.title, username: @mygroup.username } }
    assert_redirected_to mygroup_url(@mygroup)
  end

  test "should destroy mygroup" do
    assert_difference("Mygroup.count", -1) do
      delete mygroup_url(@mygroup)
    end

    assert_redirected_to mygroups_url
  end
end
