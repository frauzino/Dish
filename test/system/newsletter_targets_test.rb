require "application_system_test_case"

class NewsletterTargetsTest < ApplicationSystemTestCase
  setup do
    @newsletter_target = newsletter_targets(:one)
  end

  test "visiting the index" do
    visit newsletter_targets_url
    assert_selector "h1", text: "Newsletter targets"
  end

  test "should create newsletter target" do
    visit newsletter_targets_url
    click_on "New newsletter target"

    fill_in "Email", with: @newsletter_target.email
    click_on "Create Newsletter target"

    assert_text "Newsletter target was successfully created"
    click_on "Back"
  end

  test "should update Newsletter target" do
    visit newsletter_target_url(@newsletter_target)
    click_on "Edit this newsletter target", match: :first

    fill_in "Email", with: @newsletter_target.email
    click_on "Update Newsletter target"

    assert_text "Newsletter target was successfully updated"
    click_on "Back"
  end

  test "should destroy Newsletter target" do
    visit newsletter_target_url(@newsletter_target)
    click_on "Destroy this newsletter target", match: :first

    assert_text "Newsletter target was successfully destroyed"
  end
end
