require "application_system_test_case"

class MygroupsTest < ApplicationSystemTestCase
  setup do
    @mygroup = mygroups(:one)
  end

  test "visiting the index" do
    visit mygroups_url
    assert_selector "h1", text: "Mygroups"
  end

  test "should create mygroup" do
    visit mygroups_url
    click_on "New mygroup"

    fill_in "Countuser", with: @mygroup.countuser
    fill_in "Datein", with: @mygroup.datein
    fill_in "Description", with: @mygroup.description
    fill_in "Iid", with: @mygroup.iid
    fill_in "Title", with: @mygroup.title
    fill_in "Username", with: @mygroup.username
    click_on "Create Mygroup"

    assert_text "Mygroup was successfully created"
    click_on "Back"
  end

  test "should update Mygroup" do
    visit mygroup_url(@mygroup)
    click_on "Edit this mygroup", match: :first

    fill_in "Countuser", with: @mygroup.countuser
    fill_in "Datein", with: @mygroup.datein
    fill_in "Description", with: @mygroup.description
    fill_in "Iid", with: @mygroup.iid
    fill_in "Title", with: @mygroup.title
    fill_in "Username", with: @mygroup.username
    click_on "Update Mygroup"

    assert_text "Mygroup was successfully updated"
    click_on "Back"
  end

  test "should destroy Mygroup" do
    visit mygroup_url(@mygroup)
    click_on "Destroy this mygroup", match: :first

    assert_text "Mygroup was successfully destroyed"
  end
end
