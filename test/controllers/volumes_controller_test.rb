require 'test_helper'

class VolumesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get volumes_show_url
    assert_response :success
  end

  test "should get new" do
    get volumes_new_url
    assert_response :success
  end

  test "should get edit" do
    get volumes_edit_url
    assert_response :success
  end

end
