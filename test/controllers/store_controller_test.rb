require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success

    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', minimum: 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "sidebar should contain current date" do
    get store_index_url
    assert_response :success

    assert_select '#current-date'
  end

  test "title should exist" do
    get store_index_url
    assert_response :success

    assert_select 'h1', 'Your Pragmatic Catalog'
  end
end
