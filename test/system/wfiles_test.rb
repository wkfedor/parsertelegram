require "application_system_test_case"

class WfilesTest < ApplicationSystemTestCase
  setup do
    @wfile = wfiles(:one)
  end

  test "visiting the index" do
    visit wfiles_url
    assert_selector "h1", text: "Wfiles"
  end

  test "should create wfile" do
    visit wfiles_url
    click_on "New wfile"

    fill_in "Dateold", with: @wfile.dateold
    fill_in "Flag", with: @wfile.flag
    fill_in "Word", with: @wfile.word
    click_on "Create Wfile"

    assert_text "Wfile was successfully created"
    click_on "Back"
  end

  test "should update Wfile" do
    visit wfile_url(@wfile)
    click_on "Edit this wfile", match: :first

    fill_in "Dateold", with: @wfile.dateold
    fill_in "Flag", with: @wfile.flag
    fill_in "Word", with: @wfile.word
    click_on "Update Wfile"

    assert_text "Wfile was successfully updated"
    click_on "Back"
  end

  test "should destroy Wfile" do
    visit wfile_url(@wfile)
    click_on "Destroy this wfile", match: :first

    assert_text "Wfile was successfully destroyed"
  end
end
