require "application_system_test_case"

class TwoloadfilesTest < ApplicationSystemTestCase
  setup do
    @twoloadfile = twoloadfiles(:one)
  end

  test "visiting the index" do
    visit twoloadfiles_url
    assert_selector "h1", text: "Twoloadfiles"
  end

  test "should create twoloadfile" do
    visit twoloadfiles_url
    click_on "New twoloadfile"

    fill_in "Comment", with: @twoloadfile.comment
    fill_in "Lfilename", with: @twoloadfile.lfilename
    click_on "Create Twoloadfile"

    assert_text "Twoloadfile was successfully created"
    click_on "Back"
  end

  test "should update Twoloadfile" do
    visit twoloadfile_url(@twoloadfile)
    click_on "Edit this twoloadfile", match: :first

    fill_in "Comment", with: @twoloadfile.comment
    fill_in "Lfilename", with: @twoloadfile.lfilename
    click_on "Update Twoloadfile"

    assert_text "Twoloadfile was successfully updated"
    click_on "Back"
  end

  test "should destroy Twoloadfile" do
    visit twoloadfile_url(@twoloadfile)
    click_on "Destroy this twoloadfile", match: :first

    assert_text "Twoloadfile was successfully destroyed"
  end
end
