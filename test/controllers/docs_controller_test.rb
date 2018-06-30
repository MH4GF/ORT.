require 'test_helper'

class DocsControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get docs_about_url
    assert_response :success
  end

  test "should get contact" do
    get docs_contact_url
    assert_response :success
  end

  test "should get terms" do
    get docs_terms_url
    assert_response :success
  end

  test "should get privacy" do
    get docs_privacy_url
    assert_response :success
  end

end
