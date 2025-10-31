require "test_helper"

module Zenbook
  class BooksControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get books_index_url
      assert_response :success
    end
  end
end
