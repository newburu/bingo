require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get games_index_url
    assert_response :success
  end

  test "should get spin" do
    get games_spin_url
    assert_response :success
  end

  test "should get reset" do
    get games_reset_url
    assert_response :success
  end
end
