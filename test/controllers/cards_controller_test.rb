require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  include AuthHelper

  setup do
    user = users(:one)
    sign_in(user)
    @card = cards(:one)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should create card" do
    assert_difference("Card.count") do
      post cards_url, params: { card: { title: @card.title, text: @card.text } }
    end

    assert_response :created
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: { card: { title: "test", text: "testing" } }
    assert_response :ok
  end

  test "should destroy card" do
    assert_difference("Card.count", -1) do
      delete card_url(@card)
    end

    assert_response :no_content
  end
end
