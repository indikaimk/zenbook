require "test_helper"

module Zenbook
  class BookSubscriptionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get create" do
      get book_subscriptions_create_url
      assert_response :success
    end
  end
end
