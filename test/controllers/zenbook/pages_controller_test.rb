require "test_helper"

module Zenbook
  class PagesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get show" do
      get pages_show_url
      assert_response :success
    end

    test "should get new" do
      get pages_new_url
      assert_response :success
    end

    test "should get create" do
      get pages_create_url
      assert_response :success
    end
  end
end
