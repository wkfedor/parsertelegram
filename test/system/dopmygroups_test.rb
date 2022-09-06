require "application_system_test_case"

class DopmygroupsTest < ApplicationSystemTestCase
  setup do
    @dopmygroup = dopmygroups(:one)
  end

  test "visiting the index" do
    visit dopmygroups_url
    assert_selector "h1", text: "Dopmygroups"
  end

  test "should create dopmygroup" do
    visit dopmygroups_url
    click_on "New dopmygroup"

    fill_in "Comment", with: @dopmygroup.comment
    fill_in "Countuser", with: @dopmygroup.countuser
    fill_in "Mygroup", with: @dopmygroup.mygroup_id
    click_on "Create Dopmygroup"

    assert_text "Dopmygroup was successfully created"
    click_on "Back"
  end

  test "should update Dopmygroup" do
    visit dopmygroup_url(@dopmygroup)
    click_on "Edit this dopmygroup", match: :first

    fill_in "Comment", with: @dopmygroup.comment
    fill_in "Countuser", with: @dopmygroup.countuser
    fill_in "Mygroup", with: @dopmygroup.mygroup_id
    click_on "Update Dopmygroup"

    assert_text "Dopmygroup was successfully updated"
    click_on "Back"
  end

  test "should destroy Dopmygroup" do
    visit dopmygroup_url(@dopmygroup)
    click_on "Destroy this dopmygroup", match: :first

    assert_text "Dopmygroup was successfully destroyed"
  end
end
