require "application_system_test_case"

class LoadfilesTest < ApplicationSystemTestCase
  setup do
    @loadfile = loadfiles(:one)
  end

  test "visiting the index" do
    visit loadfiles_url
    assert_selector "h1", text: "Loadfiles"
  end

  test "should create loadfile" do
    visit loadfiles_url
    click_on "New loadfile"

    fill_in "Comment", with: @loadfile.comment
    fill_in "Lfilename", with: @loadfile.lfilename
    click_on "Create Loadfile"

    assert_text "Loadfile was successfully created"
    click_on "Back"
  end

  test "should update Loadfile" do
    visit loadfile_url(@loadfile)
    click_on "Edit this loadfile", match: :first

    fill_in "Comment", with: @loadfile.comment
    fill_in "Lfilename", with: @loadfile.lfilename
    click_on "Update Loadfile"

    assert_text "Loadfile was successfully updated"
    click_on "Back"
  end

  test "should destroy Loadfile" do
    visit loadfile_url(@loadfile)
    click_on "Destroy this loadfile", match: :first

    assert_text "Loadfile was successfully destroyed"
  end
end
