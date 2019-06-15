require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get posts_index" do
    get books_posts_index_url
    assert_response :success
  end

  test "should get viewer_index" do
    get books_viewer_index_url
    assert_response :success
  end

  test "should get new" do
    get books_new_url
    assert_response :success
  end

  test "should get edit" do
    get books_edit_url
    assert_response :success
  end

end
