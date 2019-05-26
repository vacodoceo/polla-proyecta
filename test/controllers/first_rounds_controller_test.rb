require 'test_helper'

class FirstRoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @first_round = first_rounds(:one)
  end

  test "should get index" do
    get first_rounds_url
    assert_response :success
  end

  test "should get new" do
    get new_first_round_url
    assert_response :success
  end

  test "should create first_round" do
    assert_difference('FirstRound.count') do
      post first_rounds_url, params: { first_round: { country_name: @first_round.country_name, group: @first_round.group, position: @first_round.position } }
    end

    assert_redirected_to first_round_url(FirstRound.last)
  end

  test "should show first_round" do
    get first_round_url(@first_round)
    assert_response :success
  end

  test "should get edit" do
    get edit_first_round_url(@first_round)
    assert_response :success
  end

  test "should update first_round" do
    patch first_round_url(@first_round), params: { first_round: { country_name: @first_round.country_name, group: @first_round.group, position: @first_round.position } }
    assert_redirected_to first_round_url(@first_round)
  end

  test "should destroy first_round" do
    assert_difference('FirstRound.count', -1) do
      delete first_round_url(@first_round)
    end

    assert_redirected_to first_rounds_url
  end
end
