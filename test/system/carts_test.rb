require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "adding to Cart" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    assert_text "Your Cart"
  end

  test "emptying a Cart" do
    visit store_index_url
    click_on "Add to Cart", match: :first

    assert_text "Your Cart"

    page.accept_confirm do
      click_on "Empty cart", match: :first
    end

    assert_no_text "Your Cart"
  end

  test "destroying a Cart" do
    visit carts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Your cart is currently empty"
  end
end
