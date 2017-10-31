require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dish = dishes(:one)
  end

  test "should get index" do
    get dishes_url, as: :json
    assert_response :success
  end

  test "should create dish" do
    assert_difference('Dish.count') do
      post dishes_url, params: { dish: { category: @dish.category, description: @dish.description, featured: @dish.featured, image: @dish.image, label: @dish.label, name: @dish.name, price: @dish.price } }, as: :json
    end

    assert_response 201
  end

  test "should show dish" do
    get dish_url(@dish), as: :json
    assert_response :success
  end

  test "should update dish" do
    patch dish_url(@dish), params: { dish: { category: @dish.category, description: @dish.description, featured: @dish.featured, image: @dish.image, label: @dish.label, name: @dish.name, price: @dish.price } }, as: :json
    assert_response 200
  end

  test "should destroy dish" do
    assert_difference('Dish.count', -1) do
      delete dish_url(@dish), as: :json
    end

    assert_response 204
  end
end
