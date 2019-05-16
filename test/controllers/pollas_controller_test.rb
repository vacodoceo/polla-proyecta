require 'test_helper'

class PollasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pollas_index_url
    assert_response :success
  end

  test "should get show" do
    get pollas_show_url
    assert_response :success
  end

  test "should get new" do
    get pollas_new_url
    assert_response :success
  end

  test "should get edit" do
    get pollas_edit_url
    assert_response :success
  end

end
