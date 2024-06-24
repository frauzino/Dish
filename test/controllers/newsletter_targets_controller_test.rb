require "test_helper"

class NewsletterTargetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @newsletter_target = newsletter_targets(:one)
  end

  test "should get index" do
    get newsletter_targets_url
    assert_response :success
  end

  test "should get new" do
    get new_newsletter_target_url
    assert_response :success
  end

  test "should create newsletter_target" do
    assert_difference("NewsletterTarget.count") do
      post newsletter_targets_url, params: { newsletter_target: { email: @newsletter_target.email } }
    end

    assert_redirected_to newsletter_target_url(NewsletterTarget.last)
  end

  test "should show newsletter_target" do
    get newsletter_target_url(@newsletter_target)
    assert_response :success
  end

  test "should get edit" do
    get edit_newsletter_target_url(@newsletter_target)
    assert_response :success
  end

  test "should update newsletter_target" do
    patch newsletter_target_url(@newsletter_target), params: { newsletter_target: { email: @newsletter_target.email } }
    assert_redirected_to newsletter_target_url(@newsletter_target)
  end

  test "should destroy newsletter_target" do
    assert_difference("NewsletterTarget.count", -1) do
      delete newsletter_target_url(@newsletter_target)
    end

    assert_redirected_to newsletter_targets_url
  end
end
