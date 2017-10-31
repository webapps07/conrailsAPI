require 'test_helper'

class PromotionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promotion = promotions(:one)
  end

  test "should get index" do
    get promotions_url, as: :json
    assert_response :success
  end

  test "should create promotion" do
    assert_difference('Promotion.count') do
      post promotions_url, params: { promotion: { description: @promotion.description, featured: @promotion.featured, image: @promotion.image, label: @promotion.label, name: @promotion.name, price: @promotion.price } }, as: :json
    end

    assert_response 201
  end

  test "should show promotion" do
    get promotion_url(@promotion), as: :json
    assert_response :success
  end

  test "should update promotion" do
    patch promotion_url(@promotion), params: { promotion: { description: @promotion.description, featured: @promotion.featured, image: @promotion.image, label: @promotion.label, name: @promotion.name, price: @promotion.price } }, as: :json
    assert_response 200
  end

  test "should destroy promotion" do
    assert_difference('Promotion.count', -1) do
      delete promotion_url(@promotion), as: :json
    end

    assert_response 204
  end
end
